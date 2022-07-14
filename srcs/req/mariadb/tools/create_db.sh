#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

#Check if the database exists

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 

	echo "Database already exists"
else

# Set root option so that connexion without root password is not possible

#Set root user password
#mysql --user=root -p << EOF
#
#UPDATE mysql.user SET Password=("$MYSQL_ROOT_PASSWORD") WHERE User='root';
#UPDATE mysql.user SET Plugin='mysql_native_password' WHERE User='root'
#DELETE FROM mysql.user WHERE User='';
#DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#DROP DATABASE test;
#DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
#FLUSH PRIVILEGES;
#EOF

	echo "SET PASSWORD FOR 'debian-sys-maint'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD'); FLUSH PRIVILEGES;" | mysql -uroot
	echo "SET PASSWORD FOR 'debian-sys-maint'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD'); FLUSH PRIVILEGES;"

	echo "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password; ALTER USER root@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
	echo "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password; ALTER USER root@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

#	echo "DROP DATABASE test; FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD	
#	echo "DROP DATABASE test; FLUSH PRIVILEGES;"	

#Add a root user on 127.0.0.1 to allow remote connexion

#	echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user for wordpress
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

#Import database
#mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

	sed -i "s/password = /password = $MYSQL_ROOT_PASSWORD/g" /etc/mysql/debian.cnf
fi

/etc/init.d/mysql stop
echo "this is the end"
exec "$@"
