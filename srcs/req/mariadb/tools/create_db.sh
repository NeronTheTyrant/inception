#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

#Check if the database exists

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 

	echo "Database already exists"
else

#Change root user login plugin to allow passwords, and update root password
	echo "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password; ALTER USER root@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
#Delete default test database
	echo "DROP DATABASE test; DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
#Delete blank users
	echo "DELETE FROM mysql.user WHERE User='';" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
#Explicitly prevent root remote login by deleting any root users on any host other than localhost (default in most installations)
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
#Update permissions that were altered in the previous commands
	echo "FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
#Create database and user for wordpress
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
#Debian uses a special file containing root user and password for special operations. Root users are not supposed to have passwords, so we need to update this file with the new password to avoid bugs
	sed -i "s/password = /password = $MYSQL_ROOT_PASSWORD/g" /etc/mysql/debian.cnf
fi

/etc/init.d/mysql stop
exec "$@"
