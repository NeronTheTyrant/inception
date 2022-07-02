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
	#install wordpress with url, title, admin user, password and email
	wp core install --url="$WP_URL" --title="Inception" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_MAIL" --path="/var/www/html" --allow-root
	#create additional non-admin user
	wp user create $WP_USER $WP_USER_MAIL --role="author" --user_pass="$WP_USER_PASSWORD" --path="/var/www/html" --allow-root
	
	touch /var/www/html/.installed

fi

echo "all done"

exec "$@"
