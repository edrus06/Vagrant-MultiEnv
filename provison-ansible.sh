#!/bin/bash

echo "Provision Ansible Hosts"
sudo yum clean all
sudo yum update -y
sudo yum install -y yum-utils
sudo yum install epel-release -y 


sudo yum install vim -y 

sudo useradd -m ansi_deploy
sudo usermod -aG vagrant ansi_deploy




