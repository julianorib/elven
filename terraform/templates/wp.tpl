#!/bin/bash

yum install -y amazon-efs-utils

mkdir /mnt/nfs

mount -t efs ${EFS}:/ /mnt/nfs
echo ${EFS}:/ /mnt/nfs efs _netdev,noresvport 0 0

yum install -y httpd mariadb1011-client-utils

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
    mysql -u ${DBUSER} -h ${DBHOST} -p'${DBPASS}' -e 'create database ${DB}';
fi

yum install -y php8.3 php8.3-mysqlnd 

cd /tmp/
wget https://elasticache-downloads.s3.amazonaws.com/ClusterClient/PHP-8.3/latest-64bit-x86-amzlinux-openssl3
tar -zxvf latest-64bit-x86-amzlinux-openssl3
mv amazon-elasticache-cluster-client.so /usr/lib64/php8.3/modules/
echo "extension=amazon-elasticache-cluster-client.so" | sudo tee --append /etc/php.d/50-memcached.ini

systemctl start httpd
systemctl enable httpd






