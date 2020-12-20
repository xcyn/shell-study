#!/bin/bash

FILE_PATH="./test.conf"

# 实现需求1
function getRegularArguments() {
  sed -i '' '/[:blank:]*#/d;/^$/d' test.conf 
}

#实现需求二
function getDataLine() {
  sed -i '' 's/^[^#]/\*&/g' test.conf 
}

# getRegularArguments
getDataLine