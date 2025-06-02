#!/bin/bash

#sudo mkdir /var/www/html

#sudo mount -t nfs4...

sudo yum install -y httpd #mariadb php8.3

sudo service httpd start

# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz

# cd wordpress
# cp wp-config-sample.php wp-config.php

# # acertar config banco 


# sudo cp -r ~/wordpress /var/www/html