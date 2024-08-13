#!/bin/bash

# Function to check if Nginx is installed and running
is_nginx_running() {
    if command -v nginx &> /dev/null && pgrep nginx > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to check if Apache (httpd) is installed and running
is_httpd_running() {
    if command -v httpd &> /dev/null && pgrep httpd > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to reload the appropriate service
reload_service() {
    if is_nginx_running; then
        sudo systemctl reload nginx
    elif is_httpd_running; then
        sudo systemctl reload httpd
    else
        echo "Neither Nginx nor Apache (httpd) is running on this server."
        exit 1
    fi
}

# Function to fetch the public IP address
fetch_public_ip() {
    curl -s http://icanhazip.com
}
