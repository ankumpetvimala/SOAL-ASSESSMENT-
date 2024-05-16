#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Set timezone
sudo timedatectl set-timezone Asia/Jakarta

# Install necessary packages
sudo apt install -y git curl zip unzip python3 python3-pip docker.io

# Install PHP 8.1
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php8.1 php8.1-fpm php8.1-mysql php8.1-cli php8.1-curl php8.1-mbstring php8.1-xml php8.1-zip

# Install Nginx
sudo apt install -y nginx

# Install MariaDB
sudo apt install -y mariadb-server

# Secure MariaDB installation
sudo mysql_secure_installation

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

# Additional setup tasks can be added here

# End of script
