#!/bin/bash

# Installation script to set up the package

# Make bin scripts executable
chmod +x bin/deploy_laravel.sh
chmod +x bin/deploy_laravel_config.sh

# Optionally create symbolic links to make scripts globally accessible
sudo ln -s "$(pwd)/bin/deploy_laravel.sh" /usr/local/bin/deploy_laravel
sudo ln -s "$(pwd)/bin/deploy_laravel_config.sh" /usr/local/bin/deploy_laravel_config

echo "Installation complete. You can now use 'deploy_laravel' and 'deploy_laravel_config' commands."
