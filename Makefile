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
	$(COMPOSE) up -d

# start the containers: it only starts containers that were previously stopped
start:
	$(COMPOSE) start

# build the containers: build the Docker images
build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs

# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.
clean:
	@docker ps -qa | xargs -r docker stop || true
	@docker ps -qa | xargs -r docker rm || true
	@docker images -qa | xargs -r docker rmi -f || true
	@docker volume ls -q | xargs -r docker volume rm || true
	@docker network ls -q | grep -v -e 'bridge' -e 'host' -e 'none' | xargs -r docker network rm || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true


# clean and start the containers
re: clean up

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f