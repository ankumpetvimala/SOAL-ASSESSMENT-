# SOAL-ASSESSMENT DEVOPS

1.Create a VM on the laptop/Cloud provider with the following specifications:

   a.1 vCPU
   
   b.RAM 2GB
   
   c.Storage 30GB

### 1. Create a VM with Specified Specifications

#### Using AWS:
1. *Launch an Instance*:
   - Go to the AWS Management Console.
   - Navigate to EC2 and click "Launch Instance".
   - Choose an Amazon Machine Image (AMI), preferably Ubuntu 20.04.
   - Select an instance type (e.g., t2.small).
   - Configure instance details, add storage, and configure security group (open ports 80, 443, 22).
   - Review and launch the instance.


2.Setup the app server environment with the following requirements:


#### Connect to the VM:

ssh -i your-key.pem ubuntu@your-instance-ip


#### Install Dependencies:

*Update and Upgrade:*

sudo apt update && sudo apt upgrade -y


     a.PHP 8.1
     b.Nginx 1.18/1.21
     c.MariaDB 10
     d.Dial 2.2
     e.NPM 16.X

To install PHP 8.1, Nginx 1.18/1.21, MariaDB 10, Dial 2.2, and NPM 16.X, we can use the following commands:

1.Install PHP 8.1

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.1 php8.1-fpm php8.1-mysql php8.1-xml php8.1-curl php8.1-mbstring php8.1-zip php8.1-gd

2.Install Nginx:

sudo apt install nginx

3. Install MariaDB 10:

sudo apt install mariadb-server

Secure MariaDB Installation:*

sudo mysql_secure_installation

4. Install Dial 2.2:

*Install Dial 2.2 *

sudo apt install dial-2.2 -y


*Install Node.js and npm:*

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sudo apt install -y nodejs

Install NPM 16.X (Node.js should also be installed):

# Install Node.js (npm is included)

sudo apt install nodejs

Check the installed version:

node -v

npm -v

If you have an older version of npm, you can update it:


sudo npm install -g npm@16


3.Deploy the application https://github.com/nasirkhan/laravel-starter in the VM that has been created

 4. Open the application and ensure that the following features can be used by providing proof
 screenshot :
     -Register new users
     -Login with a new user - Display posts, categories, tags & comments - Can add comments to posts
     -Run the 'forgot your password' feature (smtp email can use sendinblue.com)

### 3. Configure Nginx to Serve the Laravel Application

*Create Nginx Configuration for Laravel:*

sudo nano /etc/nginx/sites-available/laravel

*Add the following content:*

nginx

server {

    listen 80;
    
    server_name your_domain_or_ip;
    
    root /var/www/laravel/public;

    index index.php index.html index.htm;

    location / {
    
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
    
        include snippets/fastcgi-php.conf;
        
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
    
        deny all;
    }
}


*Enable the Configuration:*

sudo ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemctl restart nginx


### 4. Set up MariaDB with Required Databases and User Permissions

*Log in to MariaDB:*

sudo mysql -u root -p


*Create Database and User:*

sql

CREATE DATABASE laravel;

CREATE USER 'laraveluser'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON laravel.* TO 'laraveluser'@'localhost';

FLUSH PRIVILEGES;

EXIT;


### 5. Deploy the Laravel Application

*Clone the Laravel Starter Application:*

cd /var/www/

sudo git clone https://github.com/your-repo/laravel-starter.git laravel

cd laravel


*Install Composer (if not installed):*

sudo apt install composer -y


*Install Laravel Dependencies:*

composer install


*Set Up Environment Variables:*

cp .env.example .env
nano .env


*Update the .env file with the database credentials:*

DB_DATABASE=laravel
DB_USERNAME=laraveluser
DB_PASSWORD=password


*Generate Application Key:*

php artisan key:generate

*Run Migrations and Seeders:*

php artisan migrate --seed


*Set Permissions:*

sudo chown -R www-data:www-data /var/www/laravel

sudo chmod -R 755 /var/www/laravel/storage

git push SOAL-ASSESSMENT- master


### 6. Test the Application Features

- *Register and Verify Registration Functionality*: Open your browser and navigate to http://your_domain_or_ip/register.
- *Log In and Verify Login Functionality*: Navigate to http://your_domain_or_ip/login.
- *Navigate Through Posts, Categories, Tags, and Comments*: Verify they are displayed correctly.
- *Add Comments to Posts and Verify Comment Functionality*.
- *Test 'Forgot Your Password' Feature*: Ensure it sends emails using an SMTP service like Sendinblue.

### 7. Create a Server Setup Automation Script

Create a Bash script (setup-server.sh) with the following content:


#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Set timezone
sudo timedatectl set-timezone America/New_York

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

# Create Nginx configuration for Laravel
sudo tee /etc/nginx/sites-available/laravel > /dev/null <<EOL

server {

    listen 80;
    
    server_name your_domain_or_ip;
    
    root /var/www/laravel/public;

    index index.php index.html index.htm;

    location / {
    
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
    
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
    
        deny all;
    }
}
EOL

# Enable Nginx configuration and restart Nginx

sudo ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemctl restart nginx

# Clone Laravel starter application
sudo git clone https://github.com/your-repo/laravel-starter.git /var/www/laravel

# Set up Laravel application
cd /var/www/laravel

composer install

cp .env.example .env

php artisan key:generate

# Set permissions
sudo chown -R www-data:www-data /var/www/laravel

sudo chmod -R 755 /var/www/laravel/storage


### 8. Push the Automation Script to GitHub

*Create a New Repository:*

- Go to GitHub and create a new repository.

*Push the Automation Script:*

git init

git add setup-server.sh

git commit -m "Add server setup automation script"

git remote add origin https://github.com/your-username/your-repo.git

git push -u origin master


*Write README.md:*

Create a README.md file explaining each step:

# Server Setup Automation Script

## Overview
This script automates the setup of a server environment for a Laravel application with the following specifications:
- PHP 8.1
- Nginx 1.18/1.21
- MariaDB 10
- Dial 2.2
- NPM 16.X

## Usage
1. Clone the repository:
   
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   

2. Make the script executable:
   
   chmod +x setup-server.sh
   

3. Run the script:
   
   ./setup-server.sh
   

## Configuration
- Update the Nginx configuration in the script to match your domain or IP address.
- Ensure the database credentials in the Laravel `.env` file match your setup.

## Notes
- The script includes steps to secure the MariaDB installation.
- Adjust timezone settings as needed.


### 9. Documentation and Test Results

*Compile Documentation*:
- Document server specifications, deployment process, and include screenshots.
- Save test results and documentation in PDF format.

*Provide Compiled Documentation*:
- Ensure all steps, configurations, and test results are documented.
- Upload the PDF to your GitHub repository or share it as required.

By following these steps, you can successfully create a VM, set up the required environment, deploy a Laravel application, test its
Create a Bash/Python server setup automation script with the following environment: 

   a. Timezone Asia/ Jakarta 
   
   b. updates & upgrades
   
   c. Install Git, Curl, ZIP, python3 & python3-pip
   
   d. Install docker
   
   e.Create a GitHub account and push the automation script to the repository you have created.





