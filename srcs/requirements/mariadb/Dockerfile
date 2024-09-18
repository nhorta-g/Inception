# base image, last official base image
FROM debian:bullseye

# update and upgrade the system and cleans packeges list for optimization
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server \
		&& apt-get clean && rm -rf /var/lib/apt/lists/*

# copy file with mariaDB script from host to container
COPY ./conf/mdb-conf.sh /mdb-conf.sh

# set permissions to the file
RUN chmod +x /mdb-conf.sh

# define entrypoint command to run when the container starts,
#	meaning that mdb-conf.sh will automatically execute when the container is launched.
ENTRYPOINT ["./mdb-conf.sh"]