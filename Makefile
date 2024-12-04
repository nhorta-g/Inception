WP_DATA = /home/nhorta-g/data/wordpress #define the path to the wordpress data
DB_DATA = /home/nhorta-g/data/mariadb #define the path to the mariadb data
COMPOSE = docker compose -f ./srcs/docker-compose.yml

# default target
all: up

# start the building process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	sudo mkdir -p $(WP_DATA)
	sudo mkdir -p $(DB_DATA)
	sudo chmod -R 755 $(WP_DATA)
	sudo chmod -R 755 $(DB_DATA)
	sudo $(COMPOSE) up -d

# start the containers: it only starts containers that were previously stopped
start:
	$(COMPOSE) start

# build the containers: build the Docker images
build:
	$(COMPOSE) build

detailmdblogs:
	$(COMPOSE) exec mariadb cat /var/lib/mysql/*.err

logs:
	$(COMPOSE) logs

ps:
	@echo "**********Docker containers**********\n"
	@docker ps -a
images:
	@echo "\n**********Docker images**********\n"
	@docker images

volumes:
	@echo "\n**********Docker volumes**********\n"
	@docker volume ls

clean:
	clear
	$(COMPOSE) down --rmi all --volumes

fclean: clean
	@sudo rm -irf /home/nhorta-g/data


# clean and start the containers
re: fclean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes