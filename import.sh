#!/bin/bash

read -p 'Enter mysql root password: ' -s password
echo '' 
read -p 'Database to populate: ' database

echo 'Enabling TokuDB...'
sed -i -e "s/ENGINE=InnoDB/ENGINE=TokuDB/g" $1

echo "Drop database $database..."
mysql -u root -p$password -e "drop database $database;"

echo "Create database $database..."
mysql -u root -p$password -e "create database $database default character set utf8 default collate utf8_general_ci;"

echo "Importing file $1..."
mysql -u root -p$password $database < $1

echo 'Done.'
