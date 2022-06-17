FROM debian:buster

RUN apt-get update && apt-get -y install php-curl \
php-gd \
php-intl \
php-mbstring \
php-soap \
php-xml \
php-xmlrpc \
php-zip \
wget \
systemctl



RUN mkdir /run/php

EXPOSE 9000

CMD ["systemctl", "status", "php*", "|", "grep", "fpm.service"]

#CMD ["/usr/sbin/php-fpm7.3", "-F"]
