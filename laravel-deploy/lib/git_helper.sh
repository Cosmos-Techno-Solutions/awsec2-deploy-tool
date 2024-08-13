#!/bin/bash

# Function to prompt for input with a default value
prompt() {
    local prompt_message="$1"
    local default_value="$2"
    local input_variable

    read -p "$prompt_message [$default_value]: " input_variable
    echo "${input_variable:-$default_value}"
}

# Function to check if Git is installed and install it if not
check_install_git() {
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Installing Git..."
        sudo yum install -y git
        echo "Git installed successfully."
    else
        echo "Git is already installed."
    fi
}

# Function to clone a Git repository
clone_repository() {
    local repo_url="$1"
    local dest_dir="$2"

    if [ -d "$dest_dir" ]; then
        echo "Directory $dest_dir already exists. Please remove it or choose a different directory."
        exit 1
    fi

    echo "Cloning repository from $repo_url into $dest_dir..."
    git clone "$repo_url" "$dest_dir"
    echo "Repository cloned successfully."
}
