#!/bin/bash

# if no parameter
if [ $# -eq 0 ]; then
    echo "Please choose one: 'alias' or 'aliassu'"
    exit 1
fi

# Setting variable
chosen_param=$1

if [ "$chosen_param" = "alias" ]; then
    echo "Install all modules in alias"
    # List all files in the alias
    if [ -d "alias" ]; then
        echo "Files in alias directory:"
        ls -1 -a alias | grep -vE '^\.$|^\.\.$' | sed 's/^/--->/'
    else
        echo "Directory 'alias' does not exist."
        exit 1
    fi

    # Find home folder and .bashrc
    bashrc_file="$HOME/.bashrc"
    echo "The .bashrc file is located at: $bashrc_file"

    # Write all files in the alias into .bashrc if not already sourced
    echo "Appending source commands to .bashrc..."
    for file in alias/.*; do
        if [ -f "$file" ]; then
            source_cmd="source $(pwd)/$file"
            
            # Check if .bashrc already contains the source command
            if ! grep -Fxq "$source_cmd" "$bashrc_file"; then
                echo "$source_cmd" >> "$bashrc_file"
                echo "Added: $source_cmd" | sed 's/^/    --->/'
            else
                echo "Already exists: $source_cmd" | sed 's/^/--->/'
            fi
        fi
    done

    echo "Files from alias have been sourced into .bashrc."

elif [ "$chosen_param" = "aliassu" ]; then
    echo "Install all modules in aliassu"
    # List all files in the aliassu
    if [ -d "aliassu" ]; then
        echo "Files in aliassu directory:"
        ls -1 -a aliassu | grep -vE '^\.$|^\.\.$' | sed 's/^/--->/'
    else
        echo "Directory 'aliassu' does not exist."
        exit 1
    fi

    # Find home folder and .bashrc
    bashrc_file="$HOME/.bashrc"
    echo "The .bashrc file is located at: $bashrc_file"

    # Write all files in the aliassu into .bashrc if not already sourced
    echo "Appending source commands to .bashrc..."
    for file in aliassu/.*; do
        if [ -f "$file" ]; then
            source_cmd="source $(pwd)/$file"
            
            # Check if .bashrc already contains the source command
            if ! grep -Fxq "$source_cmd" "$bashrc_file"; then
                echo "$source_cmd" >> "$bashrc_file"
                echo "Added: $source_cmd" | sed 's/^/    --->/'
            else
                echo "Already exists: $source_cmd" | sed 's/^/--->/'
            fi
        fi
    done

    echo "Files from aliassu have been sourced into .bashrc."

else
    # If not alias or aliassu
    echo "Invalid argument. Please choose either 'alias' or 'aliassu'."
    exit 1
fi
