#!/bin/bash

# Check for sudo
if [ "$(id -u)" -ne "0" ]; then
    echo "This script requires sudo privileges. Please run it with sudo."
    exit 1
fi

# Perform tasks that need elevated permissions
echo "Changing permissions for scripts..."
sudo chmod +x bin/deploy_laravel.sh
sudo chmod +x bin/deploy_laravel_config.sh
# Optionally create symbolic links to make scripts globally accessible
sudo ln -s "$(pwd)/bin/deploy_laravel.sh" /usr/local/bin/deploy_laravel
sudo ln -s "$(pwd)/bin/deploy_laravel_config.sh" /usr/local/bin/deploy_laravel_config

# Add any other installation tasks that need sudo
echo "Installing additional dependencies..."
# e.g., sudo yum install -y some-dependency

echo "Installation completed."