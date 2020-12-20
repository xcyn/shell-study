#!/bin/bash

FILE_PATH="./test.conf"

# 实现输出 client、 service、 nginx
function getRegularArguments() {
  echo `sed -n 's/^\[//p' $FILE_PATH | sed -n 's/]//p'`
}

#实现输入client:行数、service:行数、 nginx:行数
function getDataLine() {
  lineCount=0
  allLines=`sed -n "/^$1/,/\[*/p" $FILE_PATH | sed "s/ //g" | grep -v ^$`
  for i in $allLines
  do
    lineCount=`expr $lineCount + 1`
  done
  echo $lineCount
}

echo '开始执行函数...'
for k in `getRegularArguments`
do
  echo $k':'`getDataLine $k`
done
echo '执行函数完成...'