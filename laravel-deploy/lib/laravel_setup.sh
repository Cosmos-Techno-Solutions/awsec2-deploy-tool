#!/bin/bash

# Function to setup the Laravel project
setup_laravel_project() {
    local project_dir="$1"

    # Create the SQLite database if it doesn't exist
    local sqlite_db="$project_dir/database/database.sqlite"
    if [ ! -f "$sqlite_db" ]; then
        echo "Creating SQLite database at $sqlite_db..."
        mkdir -p "$project_dir/database"
        touch "$sqlite_db"
        echo "Database created successfully."
    else
        echo "SQLite database already exists."
    fi

    # Copy .env.example to .env if .env doesn't exist
    if [ ! -f "$project_dir/.env" ]; then
        echo "Creating .env file from .env.example..."
        cp "$project_dir/.env.example" "$project_dir/.env"
        echo ".env file created successfully."
    else
        echo ".env file already exists."
    fi

    # Set permissions
    echo "Setting permissions..."
    sudo chmod -R 775 "$project_dir/bootstrap/cache"
    sudo chmod -R 777 "$project_dir/storage"
    echo "Permissions set successfully."

    # Run Composer install
    echo "Running composer install..."
    cd "$project_dir"
    composer install
    echo "Composer install completed successfully."

    # Set additional permissions
    echo "Setting additional permissions..."
    sudo chmod -R 775 "$project_dir/public/bootstrap/cache"
    sudo chmod -R 777 "$project_dir/public/storage"
    echo "Additional permissions set successfully."

    # Update AppServiceProvider.php
    # echo "Updating AppServiceProvider.php..."
    # local app_service_provider="$project_dir/app/Providers/AppServiceProvider.php"
    # if [ -f "$app_service_provider" ]; then
    #     sudo sed -i '/public function boot()/a \ \ \ \ if(config(\'app.env\') === \'production\') {\n        \URL::forceScheme(\'https\');\n    }' "$app_service_provider"
    #     echo "AppServiceProvider.php updated successfully."
    # else
    #     echo "AppServiceProvider.php not found."
    #     exit 1
    # fi
}
