FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y nginx vim curl openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pscala.42.fr/UID=pscala" \
    mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf