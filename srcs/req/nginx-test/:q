FROM debian:buster

RUN apt-get -y update && apt-get -y install nginx

COPY conf/nginx.conf /etc/nginx/conf.d

EXPOSE 8080

CMD nginx -g "daemon off;"
