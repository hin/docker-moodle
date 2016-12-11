#!/bin/sh

mysql_install_db --user root

MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=moodle
MYSQL_USER=moodle
MYSQL_PASSWORD=moodle123

cat > /tmp/db <<EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF

/usr/bin/mysqld --user=root --bootstrap < /tmp/db
rm /tmp/db

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
