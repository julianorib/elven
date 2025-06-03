#!/bin/bash

yum install nginx mariadb1011-client-utils php8.4 amazon-efs-utils -y
systemctl start nginx

mkdir /mnt/efs
mount -t efs ${EFS}:/ /mnt/efs

cd /mnt/efs
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

cd wordpress
cp wp-config-sample.php wp-config.php

mysql -h ${DBHOST} -u admin -p${DBADMINPASS} -e "CREATE DATABASE wordpress";
mysql -h ${DBHOST} -u admin -p${DBADMINPASS} -e "CREATE USER 'wordpress' IDENTIFIED by '${DBUSERPASS}' ";
mysql -h ${DBHOST} -u admin -p${DBADMINPASS} -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpress";
mysql -h ${DBHOST} -u admin -p${DBADMINPASS} -e "FLUSH PRIVILEGES";

sed -i "s/database_name_here/wordpress/g" wp-config.php
sed -i "s/username_here/wordpress/g" wp-config.php
sed -i "s/password_here/${DBUSERPASS}/g" wp-config.php
sed -i "s/localhost/${DBHOST}" wp-config.php