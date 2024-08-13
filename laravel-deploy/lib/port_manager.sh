#!/bin/bash

# Function to check if the port is already in use in the configuration file
is_port_in_use() {
    local config_file="$1"
    local port="$2"
    if grep -q "listen $port;" "$config_file" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to remove a port from the configuration file
remove_port() {
    local config_file="$1"
    local port="$2"
    if is_port_in_use "$config_file" "$port"; then
        sudo sed -i "/listen $port;/d" "$config_file"
        echo "Port $port has been removed from the configuration."
        # Reload the service to apply changes
        reload_service
    else
        echo "Port $port is not found in the configuration."
    fi
}

# Function to list all ports in the configuration file
list_ports() {
    local config_file="$1"
    echo "Listing all ports in $config_file:"
    grep -oP 'listen \K[0-9]+' "$config_file" | sort -n
}
