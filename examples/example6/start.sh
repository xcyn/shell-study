#!/bin/bash
#
FILE_PATH="./status.config"
THIS_PID="$0"

# 获取所有组
function getGroup() {
  # sed 不加 -i 代表不删除源文件
  echo `sed -n '/^\[/p' $FILE_PATH | sed -n 's/\]//p' | sed -n 's/\[//p'`
}

# 根据组名获取对应组下面的服务有哪些
function getServiceByGropName() {
  echo `sed -n "/$1/,/^\[/p" $FILE_PATH | sed "s/ //g" | grep -v ^$ | grep -v "\["`
}

# 根据服务名称返回对应的进程id
function getProcessIdByServiceName() {
  echo `ps -ef | grep $1 | grep -v grep | grep -v $THIS_PID  | awk '{print $2}'`
}

# 根据进程id获取服务的服务名称、服务分组、 状态、cpu、内存、服务开启时间
function getServiceInfoByProcessId() {
  # infoArr=()
  # 获取状态
  curService=`ps -ef | awk -v pid=12504 '$2==pid{print}' | wc -l`
  p_status="stop"
  if [ $curService -eq 1 ]; then
   p_status='running'
  else
   p_status='stop'
  fi
  # 获取cpu
  p_cpu=`ps aux | awk -v pid=12504 '$2==pid{print $3}'`
  p_mem=`ps aux | awk -v pid=12504 '$2==pid{print $4}'`
  p_startTime=`ps -p 12504 -o lstart | grep -v STARTRD`
}

# 根据服务名称获取组
function get_group_by_processname
{
	for gn in `getGroup`;do
		for pn in `getServiceByGropName $gn`;do
			if [ "$pn" == "$1" ];then
				echo "$gn"
			fi
		done
	done
}

# 主函数实现
function main() {
    # 判断函数参数
  if [ $# == 0 ]; then
    echo '
     参数规则如下:
     sh start.sh 可以列出命令有哪些
     sh start.sh -g DB 可以启动DB组下所有进程情况
     sh start.sh mysql1 可以start mysql1服务进程状态'
  elif [ $1 == -g ]; then
    array_name2=()
    arrayIndex2=0
    allGroup2=`getGroup`
    serviceInProcess=`getServiceByGropName $2`
    # 搜集所有serviece
    for groupName in $allGroup2
    do
      allServices=`getServiceByGropName $groupName`
      for serviceName in $allServices
      do
        array_name2[$arrayIndex2]=$serviceName
        arrayIndex2=$(expr $arrayIndex2 + 1)
      done
    done
    # group检测
    if [[ "${allGroup2[@]}"  =~ "$2" ]]; then
      for Parameter in $serviceInProcess
      do
      # 参数存在格式化输出
      `nohup ./mockServe/$Parameter.conf`
      done
      `sh ./status.sh $@`
    else
      echo "$2 not exists"
    fi
  else
    array_name=()
    arrayIndex=0
    allGroup=`getGroup`
    # 搜集所有serviece
    for groupName in $allGroup
    do
      allServices=`getServiceByGropName $groupName`
      for serviceName in $allServices
      do
        array_name[$arrayIndex]=$serviceName
        arrayIndex=$(expr $arrayIndex + 1)
      done
    done
    # 参数是否存在检测
    for Parameter in $@
    do
      if [[ "${array_name[@]}"  =~ "${Parameter}" ]]; then
      # 参数存在格式化输出
      `nohup ./mockServe/$Parameter.conf`
      elif [[ ! "${array_name[@]}"  =~ "${Parameter}" ]]; then
        echo "$Parameter not exists"
      fi
    done
    `sh ./status.sh $@`
  fi
}

main $@
































