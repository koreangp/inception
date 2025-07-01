#!/bin/bash

set -e

: "${MYSQL_DATABASE:?Missing}"
: "${MYSQL_USER:?Missing}"
: "${MYSQL_PASSWORD:?Missing}"
: "${MYSQL_ROOT_PASSWORD:?Missing}"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

echo "Starting MariaDB for initialization..."
mysqld_safe --datadir=/var/lib/mysql & #lancer en background 

until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

#close en background pour relancer en pid 1
echo "Shutting down MariaDB..."
mysqladmin shutdown

rm -f /root/.my.cnf

#lancer en mysql en pid 1
echo "MariaDB initialized. Starting in foreground mode..."
exec mysqld_safe --bind-address=0.0.0.0
