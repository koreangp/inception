all: build
	docker compose -f srcs/docker-compose.yml up
down:
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml down -v

build: down
	docker compose -f srcs/docker-compose.yml build

purge: down
	sudo rm -rf /home/pscala/data/*

	docker system prune -af
