all: prepare build
	docker compose -f srcs/docker-compose.yml up

prepare:
	sudo mkdir -p /home/pscala/data/mariadb
	sudo mkdir -p /home/pscala/data/wordpress
	sudo chmod 777 /home/pscala/data/mariadb
	sudo chmod 777 /home/pscala/data/wordpress



down:
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml down -v

build: down
	docker compose -f srcs/docker-compose.yml build

debug-nginx:
	docker exec -it nginx /usr/local/bin/debug/nginxdebug.sh

debug-wordpress:
	docker exec -it wordpress /usr/local/bin/debug/wordpressdebug.sh

debug-mariadb:
	docker exec -it mariadb /usr/local/bin/debug/mariadbdebug.sh

purge: down
	sudo rm -rf /home/pscala/data/*
	docker system prune -af
