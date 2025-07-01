#!/bin/bash

echo "== Vérification de l'écoute sur le port 3306 =="
netstat -tulpn | grep 3306

echo "== Vérification des utilisateurs MariaDB =="
mysql -e "SELECT User, Host FROM mysql.user;"

echo "== Vérification des privilèges pour ${MYSQL_USER} =="
mysql -e "SHOW GRANTS FOR '${MYSQL_USER}'@'%';"

echo "== Test de connexion depuis l'intérieur du conteneur =="
mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SHOW DATABASES;"

echo "== Vérification de la configuration MariaDB =="
cat /etc/mysql/mariadb.conf.d/50-server.conf