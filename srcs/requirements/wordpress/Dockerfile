FROM debian:bullseye


RUN apt update && apt upgrade -y && \
    apt install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip \
    curl mariadb-client unzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/wordpress && \
    curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf /tmp/latest.tar.gz -C /var/www --strip-components=1 && \
    rm /tmp/latest.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 775 /var/www/wordpress

# 4. Configuration PHP-FPM
# COPY conf/www.conf /etc/php/*/fpm/pool.d/www.conf

# 5. Copier un script d'initialisation WordPress (si besoin)
# COPY tools/init.sh /init.sh
# RUN chmod +x /init.sh

# 6. Lancer PHP-FPM (en mode foreground pour PID 1)
CMD ["php-fpm", "-F"]
