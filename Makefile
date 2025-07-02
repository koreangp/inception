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

purge: down
	sudo rm -rf /home/pscala/data/*
	docker system prune -af
