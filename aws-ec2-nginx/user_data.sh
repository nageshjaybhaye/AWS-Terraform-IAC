#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Welcome to the EC2 Instances created by using Terraform</h1>" | sudo tee /var/www/html/index.html