#!/bin/bash

db_user="dbuser"
db_password="123456"
db_host="192.168.1.2"

ftp_user="ftp_user"
ftp_password="redhat"
ftp_host="192.168.1.3"

src_dir="/data01/bak"
dst_dir="/data/backup"
time_date="`date +%Y%m%d%H%M%S`"
file_name="school score ${time_date}.sql"

function auto_ftp
{
ftp -inv << EOF
          open $ftp_host
          # 有权用户的账号和密码
          user $ftp_user $ftp_password
          cd $dst_dir
          put $1
          bye
EOF
}

mysqldump -u"$db_user" -p"$db_password" -h"$db_host" school score > $src_dir/$file_name && auto_ftp $src_dir/$file_name


