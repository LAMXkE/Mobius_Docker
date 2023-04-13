#!/bin/bash
#usermod -d /var/lib/mysql/ mysql
sleep 2
service mysql start

if [ ! -e "/initialized" ] 
then
    echo "Initialization"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS mobiusdb;"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD mobiusdb < mobius/mobiusdb.sql
    touch /initialized
fi
node /app/Mobius/mobius.js