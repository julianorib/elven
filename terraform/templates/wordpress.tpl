#!/bin/bash

#sudo mkdir /var/www/html

sudo yum install -y httpd #mariadb php8.3

sudo service httpd start

sudo yum install -y amazon-efs-utils
sudo mkdir /mnt/efs
sudo mount -t efs ${EFS}:/ /mnt/efs
sudo echo "${EFS}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab

# sudo mount -t efs -o tls fs-006361bfed70c204d:/ /mnt/efs

# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz

# cd wordpress
# cp wp-config-sample.php wp-config.php

# # acertar config banco 


# sudo cp -r ~/wordpress /var/www/html
