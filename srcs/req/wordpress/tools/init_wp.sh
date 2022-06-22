#! /bin/sh

if [ -f "/var/www/html/.installed" ]
then
	echo "Wordpress already installed"
else
	#install wordpress command line interface for easy setup
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp
	chmod +x /bin/wp
	
	mkdir -p /var/www/html
	chmod -R 755 /var/www/html
	chown -R 1000:1000 /var/www/html	
	
	rm -f /var/www/html/wp-config.php
	rm -f /var/www/html/wp-config-sample.php

	#download core wordpress in the right path
	wp core download --path=/var/www/html/ --locale=en_US --allow-root
	#create config file with environment values
	wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOSTNAME" --path=/var/www/html/ --allow-root
	#wp core install --url="mlebard.42.fr" --title="Bonjour" --admin_user="martinlebg" --admin_password="bglemartin" --admin_email="martinlebg@gmail.com" --path="/var/www/html"
	#wp user create martin martin@mlebard.42.fr --role="author" --user_pass="admin1234" --path="/var/www/html"
	
	touch /var/www/html/.installed

fi

echo "all done"

exec "$@"
