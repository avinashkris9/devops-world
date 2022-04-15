#!/bin/sh
yum -y install httpd php mysql php-mysql
chkconfig httpd on
systemctl start httpd
if [ ! -f /var/www/html/immersion-day-app.tar.gz ]; then
cd /var/www/html
wget https://aws-joozero.s3.ap-northeast-2.amazonaws.com/immersion-day-app.tar.gz
tar xvfz immersion-day-app.tar.gz
chown apache:root /var/www/html/rds.conf.php
fi
yum -y update