#!/bin/bash
set -e

echo "== Vérification que WordPress est installé =="
if [ -f "/var/www/wordpress/wp-config.php" ]; then
    echo "✅ wp-config.php présent"
else
    echo "❌ wp-config.php manquant !"
    exit 1
fi

echo
echo "== Vérification de la connexion à la base de données =="
wp db check --path=/var/www/wordpress --allow-root || {
    echo "❌ Problème de connexion à la base de données !"
    exit 1
}

echo
echo "== Vérification des utilisateurs WordPress =="
wp user list --path=/var/www/wordpress --allow-root

echo
echo "== Vérification de l’installation des plugins =="
wp plugin list --path=/var/www/wordpress --allow-root
