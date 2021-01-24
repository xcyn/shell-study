#!/bin/bash

user="dbuser"
password="123456"
host="192.168.1.1"
db_name="$1"
SQL="$2"

# -B 去掉美化
mysql -u "$user" -p "$password" -h "$host" -D "$db_name" -B -e "$SQL"