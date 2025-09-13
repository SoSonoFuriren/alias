# Alias Command

## 1. Install Alias

### 1.1 For Bash (Original)
```bash
git clone https://github.com/SoSonoFuriren/alias.git
cd alias
# if your kubernetes and dms tool is install in sudo mode, please choose the aliassu
./install.sh <alias||aliassu>
```

### 1.2 For Zsh (Recommended)
```bash
git clone https://github.com/SoSonoFuriren/alias.git
cd alias
# Make the script executable
chmod +x auto_install_zsh.sh
# Automated installation with intelligent configuration management
./auto_install_zsh.sh <alias||aliassu>
```

#### Features of Zsh Auto Installation:
- **Smart Detection**: Automatically detects and handles existing `.zshrc` configurations
- **Intelligent Backup**: Creates timestamped backups of your existing configurations
- **Configuration Categorization**: Organizes configurations into separate files:
  - `config/environment.zsh` - Environment variables (PATH, PKG_CONFIG_PATH, etc.)
  - `config/theme.zsh` - Zsh theme configurations
  - `config/plugins.zsh` - Plugin configurations
  - `config/oh_my_zsh.zsh` - Oh My Zsh settings
  - `config/user_config.zsh` - Your custom aliases and functions
- **Proper Loading Order**: Ensures configurations are loaded in the correct sequence
- **Non-destructive**: Preserves all your existing configurations while organizing them better

#### Installation Process:
1. **Empty .zshrc**: Direct installation with new structure
2. **Existing .zshrc**: Automatic backup, content analysis, and migration to organized structure
3. **No .zshrc**: Creates new configuration with proper structure

#### Configuration File Structure:
```
alias/
├── config/
│   ├── backups/              # Timestamped backups of original .zshrc
│   ├── environment.zsh       # Environment variables and PATH settings
│   ├── theme.zsh             # Theme configurations (ZSH_THEME, etc.)
│   ├── plugins.zsh           # Plugin settings and configurations
│   ├── oh_my_zsh.zsh         # Oh My Zsh core settings and source command
│   └── user_config.zsh       # Your custom aliases, functions, and configurations
├── alias/                    # Alias modules directory
├── aliassu/                  # Sudo alias modules directory
├── auto_install_zsh.sh           # Automated Zsh installation script
└── install.sh                # Original Bash installation script
```

#### Loading Order:
The script ensures proper loading sequence for optimal compatibility:
1. **Environment** (PATH, library paths, exports)
2. **Theme** (ZSH_THEME settings)
3. **Plugins** (plugins array and settings)
4. **Oh My Zsh** (source $ZSH/oh-my-zsh.sh)
5. **User Config** (custom aliases and functions)
6. **Alias Modules** (alias/aliassu files)

#### Migration Benefits:
- **Organized Structure**: Clean separation of different configuration types
- **Easy Management**: Edit specific configuration files without touching main .zshrc
- **Backup Safety**: All original configurations are safely backed up
- **Conflict Prevention**: Proper loading order prevents configuration conflicts
- **Upgrade Path**: Easy to update or modify specific configuration categories

## 2. Command
## 2.1 Kubernetes Relative
- getallns
    - get all namespace
- getallpod
    - get all pod information
- getallsvc
    - get all service information
- getalldpy
    - get all deployment information
- getnspod <namespace>
    - get specific namespace pod information
- getspecpod <pod name key word>
    - get specific pods information
- getspecsvc <svc name key word>
    - get specific service information
- podnsname <namespace or name key words>
    - get specific namespaces and pods
- descpod <specific pod name key word>
    - Describe specific pod
- logpod <specific pod name key word>
    - print pod log
- logpodf <specific pod name key word>
    - stream printing pod log
- delpod <specific pod name key word>
    - delete specific pod

## 2.2 xApp Relative
- getallxapp
    - get all xApp pod
- getallxappchart
    - get all onboarded xApp
- onboardxapp <config file> <Schema file>
    - onboard specific pod
- deployxapp <xApp name> <version> <xApp namespace>
    - deploy specific xApp
- undeployxapp <xApp name> <xApp namespace>
    - undeploy specific xApp
- deletexapp <XAPP_CHART_NAME> <VERSION>
    - delete a specific Chart Version from helm repository
- getrtmtable
    - list routing table
- getnbconn
    - list all e2 connection
- getnbdetail <RAN name>