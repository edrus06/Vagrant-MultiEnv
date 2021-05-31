#!/bin/bash

echo "Provision Load Balanced LB1"
sudo yum clean all
sudo yum update -y
sudo yum install -y yum-utils
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
