FROM debian:bullseye

# Installation des packages nécessaires
RUN apt update && apt upgrade -y && \
    apt install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip \
    curl mariadb-client sudo unzip && \
    rm -rf /var/lib/apt/lists/*

# Création des utilisateurs et groupes
RUN groupadd wordpress
RUN useradd -m -g wordpress wordpress
RUN usermod -aG www-data wordpress

# Création des répertoires nécessaires
RUN mkdir -p /run/php && \
    chown wordpress:wordpress /run/php
RUN mkdir -p /var/www/wordpress && \
    chown -R wordpress:wordpress /var/www/wordpress

# Installation de WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configuration PHP-FPM
COPY conf/wordpress.conf /etc/php/7.4/fpm/pool.d/wordpress.conf

# Copier le script d'initialisation WordPress
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Répertoire de travail
WORKDIR /var/www/wordpress

# Utiliser le script d'init comme point d'entrée
ENTRYPOINT ["/usr/local/bin/init.sh"]
