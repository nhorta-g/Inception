# Description: Nginx Dockerfile

# pull the base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y &&  apt-get install -y nginx openssl && \
# clean up apt cache files to minimize the image size
	apt-get clean && rm -rf /var/lib/apt/lists/*

# create the ssl directory and set permissions
RUN mkdir -p /var/www/wordpress /etc/nginx/ssl
	chown -R www-data:www-data /var/www/wordpress

# generate the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=PT/ST=Lis/Lis/O=42/OU=42/CN=nhorta-g.fr"

# copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]