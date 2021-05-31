#!/bin/bash

echo "Provision Load Balanced LB1"
sudo yum clean all
sudo yum update -y
sudo yum install -y yum-utils
sudo yum install epel-release -y 
sudo yum install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Install necessary packages"
sudo yum install -y vim net-tools
