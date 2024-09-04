#!/bin/bash

start_mariadb() {
	service mariadb start # start mariadb
	sleep 5 # wait for mariadb to start
}

configure_mariadb() {
	# Create database if not exists
	mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
	# -e flag allows you to execute a SQL statement directly from the command line.

	# Create user if not exists

	mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	# @'%': typical SQL syntax for host part of the user (@), wildcard meaning for "any host. ()"

	# Grant privileges to user, this includes permissions like SELECT, INSERT, UPDATE, DELETE, etc.
	mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

	# SQL command that tells MariaDB to reload the privilege table necessary to apply changes immideatly
	mariadb -e "FLUSH PRIVILEGES;"
}

restart_mariadb() {
	# Shutdown mariadb to restart with new config
	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

	# Restart mariadb with new config in the background to keep the container running
	mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
}

start_mariadb
configure_mariadb
restart_mariadb