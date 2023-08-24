#!/bin/bash

cd /tmp
sudo apt update
sudo apt install apache2 php unzip -y
sudo apt install php-cli php-pdo php-fpm php-json php-mysqlnd -y
sudo systemctl start apache2 && sudo systemctl enable apache2
sudo systemctl start php && sudo systemctl enable php
sudo wget --progress=bar:force https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo cp -r wordpress/* /var/www/html/
sudo systemctl reload apache2
