#!/usr/bin/env bash

#######################################################################
# This script will install Apache, PHP and Wordpress on Ubuntu 20.04. #
#######################################################################

# Installing dependencies.
sudo apt update
sudo apt install apache2 apache2-utils unzip -y
echo "<h1>Apache is operational</h1>" > /var/www/html/index.html
sudo apt install --no-install-recommends php8.1 -y
sudo apt install php8.1-{xml,fpm,mysql,zipgd,cli,mbstring,pgsql,cgi} -y
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
sudo systemctl start apache2
sudo systemctl enable apache2

# Installing Wordpress.
sudo wget --progress=bar:force -P /tmp https://wordpress.org/latest.zip
sudo unzip /tmp/latest.zip -d /var/www/html
sudo systemctl restart apache2
exit
