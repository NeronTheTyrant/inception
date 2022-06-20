#! /bin/sh

if [ ! -f "/var/www/html/.installed" ]
then
	#install wordpress command line interface for easy setup
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp
	chmod +x /bin/wp

	rm -f /var/www/html/wp-config.php
	rm -f /var/www/html/wp-config-sample.php

	#download core wordpress in the right path
	wp core download --path=/var/www/html/ --locale=en_US
	#create config file with environment values
	wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="MYSQL_PASSWORD" --dbhost="MYSQL_HOSTNAME" --path=/var/www/html/
