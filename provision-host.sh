#!/bin/bash

echo "Provision WebHost $1 "
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

echo "Machine: web"$1 >> /usr/share/nginx/html/index.html

sudo systemctl start nginx.service
echo 'Provision web'$1 'complete'


