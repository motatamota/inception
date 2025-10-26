NAME = inception
COMPOSE = docker-compose -f srcs/docker-compose.yml

all: up

up:
	$(COMPOSE) up --build -d

up-foreground:
	$(COMPOSE) up --build

logs:
	$(COMPOSE) logs -f

log_%:
	$(COMPOSE) logs -f $*

down:
	$(COMPOSE) down

mariadb:
	$(COMPOSE) up -d mariadb

nginx:
	$(COMPOSE) up -d nginx

wordpress:
	$(COMPOSE) up -d wordpress

clean: down
	docker system prune -af

fclean: clean
	docker volume rm $$(docker volume ls -q)

re: fclean all

.PHONY: all up up-foreground logs log_% down clean fclean re mariadb nginx wordpress
