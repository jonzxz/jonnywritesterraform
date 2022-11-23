#!/bin/bash
sudo amazon-linux-extras enable epel
sudo yum install epel-release -y
sudo yum install nginx -y

mkdir -p /var/www/html
aws s3 cp s3://jonny-nginx-bucket/index.html /var/www/html
sudo sed -i "s/\/usr\/share\/nginx\/html/\/var\/www\/html/" /etc/nginx/nginx.conf

sudo service nginx start