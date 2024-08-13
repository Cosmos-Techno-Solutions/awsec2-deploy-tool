# Laravel Deploy Package

## Overview
This package simplifies the deployment and configuration of Laravel applications on servers running Nginx or Apache. It automates tasks such as cloning the repository, setting up the project, and configuring server ports.

## Folder Structure

- **`bin/`**: Contains main executable scripts.
- **`lib/`**: Contains helper scripts that provide specific functionality.
- **`install.sh`**: Script to install the package and set up environment variables.
- **`README.md`**: Documentation on how to use the package.

## Installation

1. Clone this repository to your server.
2. Run the `install.sh` script:
    ```bash
    ./install.sh
    ```

## Usage

- **Deploy Laravel**: Run the following command to start the deployment process:
    ```bash
    deploy_laravel
    ```

- **Configure Laravel Ports**: Run the following command to manage server ports:
    ```bash
    deploy_laravel_config
    ```

## License
This package is licensed under the MIT License.
