awk 'BEGIN{FS=":"}{printf "%+20s\n", $2}' test3.txt