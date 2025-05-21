#!/bin/bash

# if no parameter
if [ $# -eq 0 ]; then
    echo "Please choose one to uninstall: 'alias' or 'aliassu'"
    exit 1
fi

# Setting variable
chosen_param=$1
bashrc_file="$HOME/.bashrc"

# Choose directory based on parameter
if [ "$chosen_param" = "alias" ] || [ "$chosen_param" = "aliassu" ]; then
    target_dir="$chosen_param"
    echo "Uninstalling all modules in $target_dir..."

    # Check if directory exists
    if [ -d "$target_dir" ]; then
        for file in $target_dir/.*; do
            if [ -f "$file" ]; then
                source_cmd="source $(pwd)/$file"
                
                # Remove line from .bashrc
                if grep -Fxq "$source_cmd" "$bashrc_file"; then
                    sed -i "\|$source_cmd|d" "$bashrc_file"
                    echo "Removed: $source_cmd" | sed 's/^/    --->/g'
                else
                    echo "Not found in .bashrc: $source_cmd" | sed 's/^/--->/g'
                fi
            fi
        done
        echo "Uninstall complete for $target_dir."
    else
        echo "Directory '$target_dir' does not exist."
        exit 1
    fi
else
    echo "Invalid argument. Please choose either 'alias' or 'aliassu'."
    exit 1
fi
