FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
php \
php-cgi \
php-mysql \
php-fpm \
php-pdo \
php-gd php-cli \
php-mbstring 

RUN mkdir /run/php

EXPOSE 9000

#CMD ["service", "php*", "status"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]
