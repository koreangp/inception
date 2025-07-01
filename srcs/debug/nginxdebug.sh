#!/bin/bash
set -e

echo "== Vérification que NGINX fonctionne =="
if ps aux | grep -v grep | grep nginx > /dev/null; then
  echo "✅ NGINX est bien lancé"
else
  echo "❌ NGINX n’est pas lancé !"
  exit 1
fi

echo
echo "== Vérification du port 443 (HTTPS) =="
netstat -tulpn | grep :443 || echo "❌ NGINX n’écoute pas sur le port 443 !"

echo
echo
echo "== Vérification du fichier de config principal =="
nginx -t

echo
echo
echo "== Affichage du fichier de config SSL =="
cat /etc/nginx/sites-enabled/default || echo "❌ Fichier de config SSL introuvable !"

echo
echo
echo "== Vérification du certificat SSL =="

if [ -f /etc/nginx/ssl/nginx.crt ] && [ -f /etc/nginx/ssl/nginx.key ]; then
  echo "✅ Certificat trouvé et valide"
else
  echo "❌ Certificat manquant ou invalide"
fi
