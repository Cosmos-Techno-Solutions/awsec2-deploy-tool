#!/bin/bash

# Load helper scripts
source "$(dirname "$0")/../lib/port_manager.sh"
source "$(dirname "$0")/../lib/server_helper.sh"
source "$(dirname "$0")/../lib/config_updater.sh"

# Main function to manage ports
manage_ports() {
    # Prompt for action: add, remove, or list ports
    action=$(prompt "Do you want to add, remove, or list ports? (add/remove/list)" "")

    case "$action" in
        add)
            # Prompt for inputs to add a port
            root_path=$(prompt "Enter the root path" "/var/www/laravel/public")
            public_ip=$(fetch_public_ip)

            # Loop until a valid port is entered
            while true; do
                listen_port=$(prompt "Enter the listen port" "80")

                # Determine which server is running
                if is_nginx_running; then
                    config_file="/etc/nginx/conf.d/laravel.conf"
                elif is_httpd_running; then
                    config_file="/etc/httpd/conf.d/laravel.conf"
                else
                    echo "Neither Nginx nor Apache (httpd) is running on this server."
                    exit 1
                fi

                if is_port_in_use "$config_file" "$listen_port"; then
                    echo "Port $listen_port is already in use. Please choose a different port."
                else
                    break
                fi
            done

            # Add the server block or VirtualHost
            add_server_block "$listen_port" "$root_path" "$public_ip"
            ;;
        
        remove)
            # Prompt for the port to remove
            listen_port=$(prompt "Enter the port to remove" "")

            # Determine which server is running
            if is_nginx_running; then
                config_file="/etc/nginx/conf.d/laravel.conf"
            elif is_httpd_running; then
                config_file="/etc/httpd/conf.d/laravel.conf"
            else
                echo "Neither Nginx nor Apache (httpd) is running on this server."
                exit 1
            fi

            # Remove the port from the configuration
            remove_port "$config_file" "$listen_port"
            ;;
        
        list)
            # Determine which server is running
            if is_nginx_running; then
                config_file="/etc/nginx/conf.d/laravel.conf"
            elif is_httpd_running; then
                config_file="/etc/httpd/conf.d/laravel.conf"
            else
                echo "Neither Nginx nor Apache (httpd) is running on this server."
                exit 1
            fi

            # List all ports in the configuration file
            list_ports "$config_file"
            ;;
        
        *)
            echo "Invalid option. Please choose 'add', 'remove', or 'list'."
            manage_ports
            ;;
    esac
}

# Execute the main function
manage_ports
