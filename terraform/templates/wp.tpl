#!/bin/bash

yum install -y amazon-efs-utils

mkdir /mnt/nfs

mount -t efs ${EFS}:/ /mnt/nfs
echo ${EFS}:/ /mnt/nfs efs _netdev,noresvport 0 0

yum install -y httpd

WPCONFIG="/mnt/nfs/wordpress/wp-config.php"

if [ -f "$WPCONFIG" ]; then
    echo "OK."
    rm -rf /var/www/html
    ln -s /mnt/nfs/wordpress/ /var/www/html
else
    echo "Instalando"
    cd /mnt/nfs
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz   
    cd wordpress
    cp wp-config-sample.php wp-config.php
    rm -rf /var/www/html
    ln -s /mnt/nfs/wordpress/ /var/www/html
    sed -i "s/database_name_here/${DB}/g" /mnt/nfs/wordpress/wp-config.php
    sed -i "s/username_here/${DBUSER}/g" /mnt/nfs/wordpress/wp-config.php
    sed -i "s/password_here/${DBPASS}/g" /mnt/nfs/wordpress/wp-config.php
    sed -i "s/localhost/${DBHOST}/g" /mnt/nfs/wordpress/wp-config.php
fi

yum install -y mariadb1011-client-utils php8.4 php8.4-mysqlnd 
systemctl start httpd
systemctl enable httpd

mysql -u ${DBUSER} -h ${DBHOST} -p'${DBPASS}' -e 'create database ${DB}';




