NAME = inception

all: up

up:
	docker-compose -f srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down

mariadb:
	docker-compose -f srcs/docker-compose.yml up -d mariadb

nginx:
	docker-compose -f srcs/docker-compose.yml up -d nginx

wordpress:
	docker-compose -f srcs/docker-compose.yml up -d wordpress

clean: down
	docker system prune -af

fclean: clean
	docker volume rm $$(docker volume ls -q)

re: fclean all

.PHONY: all up down clean fclean re
