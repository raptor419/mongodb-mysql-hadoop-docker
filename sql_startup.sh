#! /bin/bash
set -e

MYSQL_ROOT_PWD=${MYSQL_ROOT_PWD:-"root"}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_USER_PWD=${MYSQL_USER_PWD:-""}
MYSQL_USER_DB=${MYSQL_USER_DB:-""}

service mysql start $ sleep 10

mysql --user=root --password=root -e "UPDATE mysql.user set authentication_string=password('$MYSQL_ROOT_PWD') where user='root'; FLUSH PRIVILEGES;"

mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

mysql --user=root --password=root < /var/lib/mysql/dump.sql

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi