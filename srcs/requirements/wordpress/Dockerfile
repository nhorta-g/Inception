# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update and upgrade the system
RUN apt-get update && \
	apt-get upgrade -y

# Install required packages in a single step to minimize image layers
# php7.4-fpm, PHP-FPM (FastCGI Process Manager); php-mysql, enables
# PHP to communicate with MySQL/MariaDB; mariadb-client, usefull
# to interect with mariaDB server inside the container
RUN apt-get install --no-install-recommends -y \
	curl \
	php7.4-fpm \
	php-mysql \
	mariadb-client \
	netcat && \
# Clean up the apt cache to reduce the image size
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copy the WordPress configuration script to the root of the container
COPY conf/wp_conf.sh /wp_conf.sh

# Set executable permissions for the script
RUN chmod +x /wp_conf.sh

# Set the default entrypoint RUN the WordPress configuration script
ENTRYPOINT ["/wp_conf.sh"]