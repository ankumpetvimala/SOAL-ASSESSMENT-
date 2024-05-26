#!/bin/bash

# Set timezone
sudo timedatectl set-timezone Asia/Jakarta

# Update and upgrade
sudo apt-get update && sudo apt-get upgrade -y

# Install tools
sudo apt-get install git curl zip python3 python3-pip -y

# Install Docker
sudo apt install docker.io -y
