#!/bin/bash

sudo mkdir /var/www/html

sudo yum install -y httpd mariadb1011-client-utils php8.4

sudo service httpd start

sudo yum install -y amazon-efs-utils
sudo mount -t efs ${EFS}:/ /var/www/html
sudo echo "${EFS}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab
