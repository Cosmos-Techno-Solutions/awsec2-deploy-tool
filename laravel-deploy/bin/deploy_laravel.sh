#!/bin/bash

# Load the helper scripts from the lib directory
source "$(dirname "$0")/../lib/git_helper.sh"
source "$(dirname "$0")/../lib/laravel_setup.sh"

# Check if Git is installed, and install it if not
check_install_git

# Prompt for Git repository URL and destination directory
repo_url=$(prompt "Enter the Git repository URL" "")
dest_dir=$(prompt "Enter the destination directory" "laravel_project")

# Clone the repository
clone_repository "$repo_url" "$dest_dir"

# Setup the Laravel project
setup_laravel_project "$dest_dir"

# Call the Laravel configuration script
if [ -f "deploy_laravel_config.sh" ]; then
    echo "Calling deploy_laravel_config.sh to configure the port..."
    bash deploy_laravel_config.sh
else
    echo "deploy_laravel_config.sh not found. Please make sure it is in the same directory."
    exit 1
fi
