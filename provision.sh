#!/bin/bash

echo "Provision Load Balanced LB1"
sudo yum clean all
sudo yum update -y
sudo yum install -y yum-utils
sudo yum install epel-release -y 
sudo yum install nginx -y 

sudo systemctl start nginx.service
sudo systemctl enable nginx.service

echo "Install necessary packages"
sudo yum install -y vim net-tools git

echo "Create backup of nginx.conf"
sudo systemctl stop nginx.service

sudo cp /etc/nginx/nginx.conf /tmp/nginx-conf-$(date +"%m-%d-%y-%T")
cd /etc/nginx/
sudo git clone  https://github.com/edrus06/Nginx.git
sudo cp /etc/nginx/Nginx/nginx.conf /etc/nginx/

sudo systemctl start nginx.service