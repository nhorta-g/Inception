WP_DATA = /home/nhorta-g/data/wordpress #define the path to the wordpress data
DB_DATA = /home/nhorta-g/data/mariadb #define the path to the mariadb data

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
	docker compose -f ./srcs/docker-compose.yml up -d

# start the containers: it only starts containers that were previously stopped
start:
	docker compose -f ./srcs/docker-compose.yml start

# build the containers: build the Docker images
build:
	docker compose -f ./srcs/docker-compose.yml build

logs:
#	clear
	@echo "**********Docker logs**********\n"
	@docker compose -f ./srcs/docker-compose.yml logs

ps:
#	clear
	@echo "**********Docker containers**********\n"
	@docker ps -a

images:
#	clear
	@echo "\n**********Docker images**********\n"
	@docker images

volumes:
#	clear
	@echo "\n**********Docker volumes**********\n"
	@docker volume ls

networks:
#	clear
	@echo "\n**********Docker networks**********\n"
	@docker network ls

list: ps images volumes networks
	@echo "**********Docker list**********\n\n"

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

# clean and start the containers
re: clean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f