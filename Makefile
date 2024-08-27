# base image, last official base image
FROM debian:bullseye

# update and upgrade the system and cleans packeges list for optimization
RUN apt-get update && apt-get upgrade -y
	&& rm -rf /var/lib/apt/lists/*

# install the required packages
RUN apt-get install -y mariadb-server

# copy file with mariaDB script from host to container
COPY ./mdb-conf.sh /mdb-conf.sh

# set permissions to the file
RUN chmod +x /mdb-conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mdb-conf.sh"]