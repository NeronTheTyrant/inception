FROM debian:buster

RUN apt-get update && apt-get -y install mariadb-server mariadb-client \
&& mkdir -p /var/run/mysqld \
&& chown mysql:mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld

RUN service mysql start

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]
