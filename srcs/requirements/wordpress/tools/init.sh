#!/bin/bash
set -e

cd /var/www/wordpress

chown -R wordpress:wordpress /var/www
chmod -R 775 /var/www

# Télécharger WordPress si manquant
if [ ! -f "wp-load.php" ]; then
    echo "Téléchargement de WordPress..."
    wp core download --allow-root
fi

# Attendre que MariaDB soit disponible
echo "Attente de la base de données..."
until mysql -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e "SELECT 1" 2>/dev/null; do
    echo "MariaDB n'est pas encore disponible... nouvelle tentative dans 1 seconde"
    sleep 1
done
echo "MariaDB est prêt"

# Installer WordPress si pas déjà fait
if ! wp core is-installed --allow-root; then
    echo "Configuration de WordPress..."

    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WORDPRESS_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    wp core install \
        --url=$WORDPRESS_URL \
        --title="Inception" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    # Création d'un utilisateur normal
    if [ ! -z "$WORDPRESS_USER" ] && [ ! -z "$WORDPRESS_PASSWORD" ] && [ ! -z "$WORDPRESS_EMAIL" ]; then
        wp user create $WORDPRESS_USER $WORDPRESS_EMAIL \
            --role=author \
            --user_pass=$WORDPRESS_PASSWORD \
            --allow-root
        echo "Utilisateur $WORDPRESS_USER créé avec succès"
    fi
else
    echo "WordPress est déjà installé"
fi

# Correction des permissions finales
chown -R wordpress:wordpress /var/www/wordpress

echo "Démarrage de PHP-FPM..."
exec php-fpm -F
