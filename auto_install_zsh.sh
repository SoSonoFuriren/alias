#!/bin/bash

# Auto Installation Script for zsh configuration
# Supports intelligent detection, migration and merging of existing configurations

# Color output functions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Configuration
ZSHRC_FILE="$HOME/.zshrc"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
BACKUP_DIR="$CONFIG_DIR/backups"
USER_CONFIG_FILE="$CONFIG_DIR/user_config.zsh"
OH_MY_ZSH_CONFIG="$CONFIG_DIR/oh_my_zsh.zsh"
ENV_CONFIG="$CONFIG_DIR/environment.zsh"
THEME_CONFIG="$CONFIG_DIR/theme.zsh"
PLUGINS_CONFIG="$CONFIG_DIR/plugins.zsh"

# Default zsh content patterns (to identify native vs user-added content)
DEFAULT_ZSH_PATTERNS=(
    "^# If you come from bash"
    "^# Path to your oh-my-zsh installation"
    "^export ZSH="
    "^ZSH_THEME="
    "^# Uncomment the following line"
    "^# plugins="
    "^plugins="
    "^source \$ZSH/oh-my-zsh.sh"
    "^# User configuration"
    "^# export MANPATH="
    "^# You may need to manually set your language environment"
    "^# export LANG="
    "^# Preferred editor for local and remote sessions"
    "^# if \[\[ -n \$SSH_CONNECTION \]\]"
    "^# export EDITOR="
    "^# Compilation flags"
    "^# export ARCHFLAGS="
    "^# Set personal aliases"
    "^# Example aliases"
    "^# alias zshconfig="
    "^# alias ohmyzsh="
)

# Function to check if line is default zsh content
is_default_zsh_line() {
    local line="$1"
    
    # Empty lines and comments starting with # are considered default
    if [[ -z "$line" ]] || [[ "$line" =~ ^[[:space:]]*$ ]] || [[ "$line" =~ ^[[:space:]]*#.*$ ]]; then
        return 0
    fi
    
    # Check against known default patterns
    for pattern in "${DEFAULT_ZSH_PATTERNS[@]}"; do
        if [[ "$line" =~ $pattern ]]; then
            return 0
        fi
    done
    
    return 1
}

# Function to create config directory structure
create_config_structure() {
    print_info "Creating config directory structure..."
    mkdir -p "$CONFIG_DIR"
    mkdir -p "$BACKUP_DIR"
    print_success "Config directories created at $CONFIG_DIR"
}

# Function to backup existing zshrc
backup_zshrc() {
    if [ -f "$ZSHRC_FILE" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local backup_file="$BACKUP_DIR/zshrc_backup_$timestamp"
        cp "$ZSHRC_FILE" "$backup_file"
        print_success "Backup created: $backup_file"
    fi
}

# Function to check if line exists in file (ignoring whitespace variations)
line_exists_in_file() {
    local line="$1"
    local file="$2"
    
    if [ ! -f "$file" ]; then
        return 1
    fi
    
    # Normalize the line (remove leading/trailing whitespace)
    local normalized_line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Skip empty lines
    if [ -z "$normalized_line" ]; then
        return 0
    fi
    
    # Check if normalized line exists in file
    while IFS= read -r existing_line; do
        local normalized_existing=$(echo "$existing_line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        if [ "$normalized_line" = "$normalized_existing" ]; then
            return 0
        fi
    done < "$file"
    
    return 1
}

# Function to merge content into config file
merge_content_to_file() {
    local target_file="$1"
    local header="$2"
    shift 2
    local lines=("$@")
    
    if [ ${#lines[@]} -eq 0 ]; then
        return
    fi
    
    print_info "Merging content to $(basename "$target_file")..."
    
    # Create file with header if it doesn't exist
    if [ ! -f "$target_file" ]; then
        cat > "$target_file" << EOF
$header

EOF
    fi
    
    # Read existing content to avoid duplicates
    local added_count=0
    local duplicate_count=0
    
    for line in "${lines[@]}"; do
        if ! line_exists_in_file "$line" "$target_file"; then
            echo "$line" >> "$target_file"
            ((added_count++))
        else
            ((duplicate_count++))
        fi
    done
    
    if [ $added_count -gt 0 ]; then
        print_success "Added $added_count new lines to $(basename "$target_file")"
    fi
    
    if [ $duplicate_count -gt 0 ]; then
        print_info "Skipped $duplicate_count duplicate lines in $(basename "$target_file")"
    fi
}

# Function to extract plugin names from plugins array
extract_plugin_names() {
    local plugins_line="$1"
    
    # Extract content between parentheses
    local plugins_content=$(echo "$plugins_line" | sed -n 's/.*plugins=(\([^)]*\)).*/\1/p')
    
    if [ -z "$plugins_content" ]; then
        return
    fi
    
    # Split by whitespace and clean up
    echo "$plugins_content" | tr ' ' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;/^$/d'
}

# Function to merge plugins intelligently
merge_plugins() {
    local new_plugins=("$@")
    
    if [ ${#new_plugins[@]} -eq 0 ]; then
        return
    fi
    
    print_info "Merging plugins configuration..."
    
    # Create plugins config if it doesn't exist
    if [ ! -f "$PLUGINS_CONFIG" ]; then
        cat > "$PLUGINS_CONFIG" << 'EOF'
# Plugins Configuration
# Oh My Zsh plugins and related settings

EOF
    fi
    
    # Read existing plugins
    local existing_plugins=()
    if [ -f "$PLUGINS_CONFIG" ]; then
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*plugins= ]]; then
                local extracted_plugins=($(extract_plugin_names "$line"))
                existing_plugins+=("${extracted_plugins[@]}")
            fi
        done < "$PLUGINS_CONFIG"
    fi
    
    # Merge and deduplicate plugins
    local all_plugins=($(printf '%s\n' "${existing_plugins[@]}" "${new_plugins[@]}" | sort -u))
    
    # Check if we have a plugins line to update
    local has_plugins_line=false
    if [ -f "$PLUGINS_CONFIG" ] && grep -q "^[[:space:]]*plugins=" "$PLUGINS_CONFIG"; then
        has_plugins_line=true
    fi
    
    if [ $has_plugins_line = true ]; then
        # Update existing plugins line
        local plugins_string=$(printf '%s ' "${all_plugins[@]}")
        plugins_string=${plugins_string% } # Remove trailing space
        
        # Create temporary file with updated plugins
        local temp_file=$(mktemp)
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*plugins= ]]; then
                echo "plugins=($plugins_string)"
            else
                echo "$line"
            fi
        done < "$PLUGINS_CONFIG" > "$temp_file"
        
        mv "$temp_file" "$PLUGINS_CONFIG"
        print_success "Updated plugins array with merged plugins"
    else
        # Add new plugins line
        local plugins_string=$(printf '%s ' "${all_plugins[@]}")
        plugins_string=${plugins_string% } # Remove trailing space
        echo "plugins=($plugins_string)" >> "$PLUGINS_CONFIG"
        print_success "Added plugins array with merged plugins"
    fi
}

# Function to categorize and extract content from existing zshrc
categorize_and_extract_content() {
    if [ ! -f "$ZSHRC_FILE" ]; then
        return
    fi
    
    print_info "Analyzing and categorizing existing .zshrc content..."
    
    local oh_my_zsh_lines=()
    local env_lines=()
    local theme_lines=()
    local plugin_lines=()
    local user_lines=()
    
    while IFS= read -r line; do
        # Skip empty lines and pure comments (but preserve configuration comments)
        if [[ -z "$line" ]] || [[ "$line" =~ ^[[:space:]]*$ ]]; then
            continue
        fi
        
        # Categorize lines based on content
        if [[ "$line" =~ ^[[:space:]]*#.*$ ]]; then
            # Keep configuration-related comments with their respective categories
            if [[ "$line" =~ (theme|Theme|THEME) ]]; then
                theme_lines+=("$line")
            elif [[ "$line" =~ (plugin|Plugin|PLUGIN) ]]; then
                plugin_lines+=("$line")
            elif [[ "$line" =~ (PATH|MANPATH|LANG|EDITOR|export|Environment) ]]; then
                env_lines+=("$line")
            elif [[ "$line" =~ (oh-my-zsh|Oh My Zsh|OMZ) ]]; then
                oh_my_zsh_lines+=("$line")
            else
                user_lines+=("$line")
            fi
        elif [[ "$line" =~ ^[[:space:]]*export[[:space:]]+ZSH= ]] || [[ "$line" =~ ^[[:space:]]*source.*oh-my-zsh\.sh ]]; then
            oh_my_zsh_lines+=("$line")
        elif [[ "$line" =~ ^[[:space:]]*export[[:space:]]+(PATH|PKG_CONFIG_PATH|LD_LIBRARY_PATH|MANPATH|LANG|EDITOR|ARCHFLAGS) ]]; then
            env_lines+=("$line")
        elif [[ "$line" =~ ^[[:space:]]*ZSH_THEME= ]] || [[ "$line" =~ ^[[:space:]]*ZSH_THEME_RANDOM_CANDIDATES= ]]; then
            theme_lines+=("$line")
        elif [[ "$line" =~ ^[[:space:]]*plugins= ]] || [[ "$line" =~ ^[[:space:]]*zstyle.*:omz: ]]; then
            plugin_lines+=("$line")
        elif [[ "$line" =~ ^[[:space:]]*(CASE_SENSITIVE|HYPHEN_INSENSITIVE|DISABLE_|ENABLE_|COMPLETION_|HIST_|ZSH_CUSTOM)= ]]; then
            oh_my_zsh_lines+=("$line")
        else
            user_lines+=("$line")
        fi
    done < "$ZSHRC_FILE"
    
    # Create Oh My Zsh configuration file
    if [ ${#oh_my_zsh_lines[@]} -gt 0 ]; then
        print_info "Creating Oh My Zsh configuration file..."
        cat > "$OH_MY_ZSH_CONFIG" << 'EOF'
# Oh My Zsh Configuration
# Basic Oh My Zsh setup and options

EOF
        printf '%s\n' "${oh_my_zsh_lines[@]}" >> "$OH_MY_ZSH_CONFIG"
        print_success "Oh My Zsh config saved to $OH_MY_ZSH_CONFIG"
    fi
    
    # Create Environment configuration file
    if [ ${#env_lines[@]} -gt 0 ]; then
        print_info "Creating Environment configuration file..."
        cat > "$ENV_CONFIG" << 'EOF'
# Environment Configuration
# PATH, library paths, and other environment variables

EOF
        printf '%s\n' "${env_lines[@]}" >> "$ENV_CONFIG"
        print_success "Environment config saved to $ENV_CONFIG"
    fi
    
    # Create Theme configuration file
    if [ ${#theme_lines[@]} -gt 0 ]; then
        print_info "Creating Theme configuration file..."
        cat > "$THEME_CONFIG" << 'EOF'
# Theme Configuration
# Zsh and Oh My Zsh theme settings

EOF
        printf '%s\n' "${theme_lines[@]}" >> "$THEME_CONFIG"
        print_success "Theme config saved to $THEME_CONFIG"
    fi
    
    # Create Plugins configuration file
    if [ ${#plugin_lines[@]} -gt 0 ]; then
        print_info "Creating Plugins configuration file..."
        cat > "$PLUGINS_CONFIG" << 'EOF'
# Plugins Configuration
# Oh My Zsh plugins and related settings

EOF
        printf '%s\n' "${plugin_lines[@]}" >> "$PLUGINS_CONFIG"
        print_success "Plugins config saved to $PLUGINS_CONFIG"
    fi
    
    # Create User configuration file
    if [ ${#user_lines[@]} -gt 0 ]; then
        print_info "Creating User configuration file..."
        cat > "$USER_CONFIG_FILE" << 'EOF'
# User-defined Configuration
# Custom aliases, functions, and personal configurations

EOF
        printf '%s\n' "${user_lines[@]}" >> "$USER_CONFIG_FILE"
        print_success "User config saved to $USER_CONFIG_FILE"
    fi
    
    print_success "Content categorization completed!"
}

# Function to install alias files
install_alias_files() {
    local dir_name="$1"
    
    if [ ! -d "$SCRIPT_DIR/$dir_name" ]; then
        print_error "Directory '$dir_name' does not exist in $SCRIPT_DIR"
        return 1
    fi
    
    print_info "Installing modules from $dir_name directory..."
    
    # List files in the directory
    print_info "Files in $dir_name directory:"
    find "$SCRIPT_DIR/$dir_name" -type f -name ".*" | while read -r file; do
        echo "    ---> $(basename "$file")"
    done
    
    # Add source commands to zshrc
    print_info "Adding source commands to .zshrc..."
    
    for file in "$SCRIPT_DIR/$dir_name"/.*; do
        if [ -f "$file" ]; then
            local source_cmd="source $file"
            
            # Check if .zshrc already contains the source command
            if ! grep -Fxq "$source_cmd" "$ZSHRC_FILE" 2>/dev/null; then
                echo "$source_cmd" >> "$ZSHRC_FILE"
                print_success "Added: $source_cmd"
            else
                print_warning "Already exists: $source_cmd"
            fi
        fi
    done
}

# Function to create new zshrc with proper structure
create_new_zshrc() {
    print_info "Creating new .zshrc with proper structure..."
    
    cat > "$ZSHRC_FILE" << EOF
# Zsh configuration managed by auto_install script
# 
# This file is automatically managed. Your configurations are organized
# into separate files under $CONFIG_DIR

# Load Environment configurations
if [ -f "$ENV_CONFIG" ]; then
    source "$ENV_CONFIG"
fi

# Load Theme configurations
if [ -f "$THEME_CONFIG" ]; then
    source "$THEME_CONFIG"
fi

# Load Plugins configurations
if [ -f "$PLUGINS_CONFIG" ]; then
    source "$PLUGINS_CONFIG"
fi

# Load Oh My Zsh configurations (must be after theme and plugins)
if [ -f "$OH_MY_ZSH_CONFIG" ]; then
    source "$OH_MY_ZSH_CONFIG"
fi

# Load User configurations
if [ -f "$USER_CONFIG_FILE" ]; then
    source "$USER_CONFIG_FILE"
fi

# Alias modules will be sourced below this line
# (Auto-generated content - do not edit manually)

EOF
    
    print_success "New .zshrc created with proper structure"
}

# Function to ensure proper Oh My Zsh configuration
ensure_oh_my_zsh_config() {
    print_info "Ensuring proper Oh My Zsh configuration..."
    
    local required_lines=(
        '# Path to your Oh My Zsh installation.'
        'export ZSH="$HOME/.oh-my-zsh"'
        'source $ZSH/oh-my-zsh.sh'
    )
    
    if [ ! -f "$OH_MY_ZSH_CONFIG" ]; then
        cat > "$OH_MY_ZSH_CONFIG" << 'EOF'
# Oh My Zsh Configuration
# Basic Oh My Zsh setup and options

EOF
    fi
    
    for line in "${required_lines[@]}"; do
        if ! line_exists_in_file "$line" "$OH_MY_ZSH_CONFIG"; then
            echo "$line" >> "$OH_MY_ZSH_CONFIG"
            print_success "Added required Oh My Zsh line: $line"
        fi
    done
}

# Function to create new zshrc that preserves all configurations
create_comprehensive_zshrc() {
    print_info "Creating comprehensive .zshrc with proper structure..."
    
    cat > "$ZSHRC_FILE" << EOF
# Zsh configuration managed by auto_install script
# 
# This file is automatically managed. Your configurations are organized
# into separate files under $CONFIG_DIR
# All existing configurations have been preserved and merged.

# Load Environment configurations (loaded first for PATH and exports)
if [ -f "$ENV_CONFIG" ]; then
    source "$ENV_CONFIG"
fi

# Load Theme configurations (must be before Oh My Zsh)
if [ -f "$THEME_CONFIG" ]; then
    source "$THEME_CONFIG"
fi

# Load Plugins configurations (must be before Oh My Zsh)
if [ -f "$PLUGINS_CONFIG" ]; then
    source "$PLUGINS_CONFIG"
fi

# Load Oh My Zsh configurations (must be after theme and plugins)
if [ -f "$OH_MY_ZSH_CONFIG" ]; then
    source "$OH_MY_ZSH_CONFIG"
fi

# Load User configurations (loaded last to override defaults)
if [ -f "$USER_CONFIG_FILE" ]; then
    source "$USER_CONFIG_FILE"
fi

# Alias modules will be sourced below this line
# (Auto-generated content - do not edit manually)

EOF
    
    print_success "Comprehensive .zshrc created with proper loading order"
}

# Enhanced main installation function
main() {
    print_info "Starting automated zsh configuration installation with intelligent merging..."
    print_info "Script directory: $SCRIPT_DIR"
    
    # Check parameters
    if [ $# -eq 0 ]; then
        print_error "Please choose one: 'alias' or 'aliassu'"
        echo "Usage: $0 <alias|aliassu>"
        exit 1
    fi
    
    local chosen_param="$1"
    
    if [[ "$chosen_param" != "alias" && "$chosen_param" != "aliassu" ]]; then
        print_error "Invalid argument. Please choose either 'alias' or 'aliassu'."
        exit 1
    fi
    
    # Create config structure
    create_config_structure
    
    # Analyze .zshrc situation
    print_info "Analyzing .zshrc situation..."
    
    if [ ! -f "$ZSHRC_FILE" ]; then
        # Situation 1: No .zshrc file exists
        print_warning "No .zshrc file found. Creating new configuration."
        ensure_oh_my_zsh_config
        create_comprehensive_zshrc
        
    elif [ ! -s "$ZSHRC_FILE" ]; then
        # Situation 2: .zshrc exists but is empty
        print_info ".zshrc exists but is empty. Creating new configuration."
        ensure_oh_my_zsh_config
        create_comprehensive_zshrc
        
    else
        # Situation 3: .zshrc exists and has content
        print_info ".zshrc exists with content. Analyzing, merging and preserving all configurations..."
        
        # Backup existing file
        backup_zshrc
        
        # Extract, categorize and merge content
        categorize_and_merge_content
        
        # Ensure Oh My Zsh is properly configured
        ensure_oh_my_zsh_config
        
        # Create comprehensive structured zshrc
        create_comprehensive_zshrc
    fi
    
    # Install alias files
    install_alias_files "$chosen_param"
    
    # Final success message
    print_success "Installation completed successfully with intelligent merging!"
    print_info "All existing configurations have been preserved and organized:"
    echo "  - Main config: $ZSHRC_FILE"
    echo "  - Environment: $ENV_CONFIG"
    echo "  - Theme: $THEME_CONFIG"
    echo "  - Plugins: $PLUGINS_CONFIG"
    echo "  - Oh My Zsh: $OH_MY_ZSH_CONFIG"
    echo "  - User config: $USER_CONFIG_FILE"
    echo "  - Backups: $BACKUP_DIR"
    echo ""
    print_info "✓ No configurations were lost"
    print_info "✓ Duplicates were automatically removed"
    print_info "✓ Proper loading order established"
    echo ""
    print_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
}

# Run main function with all arguments
main "$@"