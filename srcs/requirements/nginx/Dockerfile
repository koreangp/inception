FROM debian:bullseye

RUN apt update && apt-get upgrade -y && \
    apt install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
        -newkey rsa:2048 \
        -out /etc/nginx/ssl/nginx.crt \
        -keyout /etc/nginx/ssl/nginx.key \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pscala.42.fr/UID=pscala" && \
    mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/sites-enabled/pscala.42.fr.conf

CMD ["nginx", "-g", "daemon off;"]
