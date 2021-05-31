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
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    upstream testapp {
        server 10.0.0.11;
        server 10.0.0.12;
    }
        server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;
        location / {
          proxy_set_header Host $1;
          proxy_set_header X-Real-IP $2;
          proxy_set_header X-Forwarded-For $3;
          proxy_pass http://testapp;
        }
        #location / {
        #}

        #error_page 404 /404.html;
        #location = /404.html {
        #}

        #error_page 500 502 503 504 /50x.html;
        #location = /50x.html {
        #}
    }
}


" > /etc/nginx/nginx.conf

sudo systemctl start nginx.service