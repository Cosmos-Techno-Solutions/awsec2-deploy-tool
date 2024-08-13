#!/bin/bash

# Function to add a new server block or VirtualHost
add_server_block() {
    local listen_port="$1"
    local root_path="$2"
    local public_ip="$3"

    # Determine which server is running
    if is_nginx_running; then
        config_file="/etc/nginx/conf.d/laravel.conf"
        # Define the Nginx server block template with the public IP address
        server_block="server {
            listen $listen_port;
            server_name $public_ip;  # Use the public IP address

            root $root_path;  # Path to your Laravel application's public directory
            index index.php index.html index.htm;

            location / {
                try_files \$uri \$uri/ /index.php?\$query_string;
            }

            location ~ \.php$ {
                include fastcgi_params;
                fastcgi_pass unix:/run/php-fpm/www.sock;  # Use this if PHP-FPM is configured to use a socket
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
            }

            location ~ /\.ht {
                deny all;
            }
        }"

        # Update the Nginx configuration file
        echo "$server_block" | sudo tee -a "$config_file"

    elif is_httpd_running; then
        config_file="/etc/httpd/conf.d/laravel.conf"
        # Define the Apache VirtualHost block template with the public IP address
        server_block="<VirtualHost *:$listen_port>
        ServerName $public_ip

        DocumentRoot $root_path
        DirectoryIndex index.php index.html

        <Directory $root_path>
            AllowOverride All
            Require all granted
        </Directory>

        <FilesMatch \.php$>
            SetHandler \"proxy:unix:/run/php-fpm/www.sock|fcgi://localhost/\"
        </FilesMatch>

        ErrorLog \"/var/log/httpd/laravel_error.log\"
        CustomLog \"/var/log/httpd/laravel_access.log\" combined
    </VirtualHost>"

        # Update the Apache configuration file
        echo "$server_block" | sudo tee -a "$config_file"

    else
        echo "Neither Nginx nor Apache (httpd) is running on this server."
        exit 1
    fi

    # Reload the service to apply the changes
    reload_service
    echo "Server configuration updated and reloaded successfully."
}
