#!/bin/bash

 if ! pgrep mariadbd > /dev/null; then
	service mariadb start
	sleep 5
fi

#--------------mariadb config--------------
mariadb -u root << EOF
    CREATE DATABASE IF NOT EXISTS $MYSQL_DB;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOF

#--------------mariadb restart--------------
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'