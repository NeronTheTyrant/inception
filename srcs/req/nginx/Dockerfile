FROM debian:buster

RUN apt-get update && apt-get -y install nginx \
openssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/mlebard.42.fr.pem -keyout /etc/ssl/mlebard.42.fr.key -subj "/C=FR/ST=Ile-De-France/L=Paris/O=42/OU=mlebard/CN=mlebard.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
