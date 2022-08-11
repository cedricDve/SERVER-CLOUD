#! /bin/bash

sudo apt-get update
sudo apt-get install lynx -y

# Install NGINX, MySQL, PHP, phpMyAdmin , Docker, Minikube and kubectl

# Install NGINX
sudo apt-get install nginx -y
sudo ufw allow 80

# Install MySQL
sudo apt-get install mysql-server -y

# Install PHP
sudo apt install php-fpm -y
sudo apt install php-mysql -y

# To Install phpmyadmin: sudo apt install phpmyadmin -y

# Install Docker
apt-get install docker.io -y
## Add "vagrant" user to docker Group
usermod -aG docker vagrant 

# Install Minikube
curl --insecure -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64

# Install kubectl
sudo snap install kubectl --classic    