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
sudo yum install -y vim net-tools

echo "Create backup of nginx.conf"
sudo systemctl stop nginx.service

sudo cp /etc/nginx/nginx.conf /tmp/nginx-conf-$(date +"%m-%d-%y-%T")

echo "
    upstream backend {
        server 10.0.0.11;
        server 10.0.0.12;
    }
	
    server {
        listen      80 default_server;
        listen      [::]:80 default_server;
        server_name lb1.vagrant.vm;

        location / {
	        proxy_redirect      off;
	        proxy_set_header    X-Real-IP $remote_addr;
	        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
	        proxy_set_header    Host $http_host;
		proxy_pass http://backend;
	}
}

" > /etc/nginx/nginx.conf

sudo systemctl start nginx.service