FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
php \
php-cgi \
php-mysql \
php-fpm \
php-pdo \
php-gd php-cli \
php-mbstring \
mariadb-client

RUN mkdir /run/php

RUN sed -i 's/listen = \/run\/php\/php7\.3-fpm\.sock/listen = 0\.0\.0\.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

#CMD ["service", "php*", "status"]

COPY ./tools/init_wp.sh /usr/local/bin/

ENTRYPOINT ["init_wp.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]
