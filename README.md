# shell学习记录
### 如何理解shell
  + Shell是Linux/Unix的一个外壳，你理解成衣服也行。它负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序.
### 使用场景
 + 部署、工具
### 基础使用
  + 变量
    + 自定义变量
      ```
      var1=1
      echo $var1
      ```
    + 位置变量
      ```
      sh 1.sh hello word 123
      hello word 123 属于位置变量
      $1 可以获取 hello
      $@ 获取所有参数
      $# 获取参数个数
      ```
    + 环境变量
      + 对所有用户生效的环境变量 /etc/profile
        + 常用环境变量
          + PATH 命令搜索的路径
          + HOME 用户家目录的路径
          + LOGNAME 用户登陆名
          + PWD 当前所在路径
          + HISTFILE 历史命令的保存文件
          + HISTSIZE 历史命令保存的最大行数
          + HOSTNAME 主机名
          + SHELL 用户当前使用的shell
      + 对特定用户生效的环境变量 ~/.bashrc或者~/.bash_profile
      + 临时有效的环境变量 脚本或者命令行使用export
  + 简单脚本
    + 创建文件
    ```
    touch text.sh
    vim text.sh
    ```
    + 文件内容
    ```
    #!/bin/bash
    var1=1
    echo $var1
    ```
    + 执行文件
    ```
    sh text.sh
    ```
  + 管道 (把一个命令输出作为另一个命令输入)
    + 找出系统说所有软件的python相关
    ```
      rpm -qa | grep python
    ```
  + 退出状态码
  ```
  echo $?
  ```
  + 默认分隔符IFS-> 默认会按照空格和tab来分割
  + IFS=":" 如果这么设置，系统将以：为系统分隔符
### 基本语法
  + if - elseif
    ```
    if [ $0 == 1 ]; then
      echo "命令参数为输入:1"
    elif [ $0 == 2 ]; then
        echo "命令参数为输入:2"
    else
        echo "参数不是1和2"
    fi
    ```
  + 数值比较
    ```
    [ n1 -eq n2 ] -> n1==n2
    n1 -ne n2 -> n1!=n2
    n1 -gt n2 -> n1>n2
    n1 -ge n2 -> n1>=n2
    n1 -lt n2 -> n1<n2
    n1 -le n2 -> n1<=n2
    ```
  + 加减运算
    ```
    varb=11
    a=$(expr $varb + 1)
    echo $a
    ```
  + 文件比较
    + -d file file是否为目录
    + -f file file是否为文件
    + -e file file是否存在
    + -r file file是否可读
    + -w file file是否可写
    + -x file file是否可执行
    + -s file file存在且非空
    + file1 -nt file2 flie1比file新为true
    + file1 -ot file2 flie1比file旧为true
  + 双括号
    ```
    [[]] 也可以
    if (( $1 == $2 )) && (( $3 == $2 )); then
      echo "$1 == $2 == $3"
    elif (( $1 > $2 )) && (( $1 > $3 )); then
      echo "$1 最大"
    elif [ $1 < $2 ]; then
      echo "$1 < $2"
    fi
    ```
  + case语法
    ```
    case $1 in
      1 )
      echo 1
      ;;
      2 )
      echo 2
      ;;
      * )
      echo "unknown command"
      ;;
    esac
    ```
### for循环
  + 字符串循环
  ```
  for i in h1 h2 h3 h4
  do
    echo $i
  done
  ```
  + 数字循环
  ```
  for i in {1..20}
  do
    echo $i
  done
  ```
  + 变量执行结果
  ```
  FILE=$(ls)
  for i in $FILE
  do
    echo $i
  done
  ```
  + while循环(until循环和while循环条件正好相反)
  ```
  num=1
  while (( num < 20 ))
  do
    echo $num
    (( num++ ))
  done
  ```
  + break指令, 终止循环
  ```
  for i in {1..20}
  do
    if [ $i == 10 ]; then
      break
    else
      echo $i
    fi
  done
  ```
  + 处理循环输出
    for i in {1..20}
  do
    if [ $i == 10 ]; then
      break
    else
      echo $i
    fi
  done > echo.txt
  ```
### 常用命令
  + find命令 语法: find[路径][选项][操作]
    + 选项
    ```
    -name 根据文件名称查找
    -iname 根据文件名称查找 (不区分文件名字大小写)
    -perm 根据文件权限查找
    -prune 根据选项可以排除某些查找目录
    -user 根据文件属主查找
    -group 根据文件属组查找
    -mtime -n | +n 根据文件更改时间查找 （常用）
    -type 按照文件类型查找
    -newer file1!file2 查找更改时间比file1新但是比file2旧的文件
    -mindepth n 根据几级目录开始搜索
    ```
    + 操作
    -print 打印输出
    -exec 接命令
    ```
    find ./test -exec rm -rf {} \;
    ```
    + 案例
    ```
    find . --path ./test1 -prune -o --path ./test2 --prune -o -type f
    查当前目录文件， 排除 test1 和 test2 目录
    ```
### 文本三剑客
+ grep | egrep 过滤器
+ 语法 grep [option] [pattern] [file,file....]
+ 选项
  + -v 反相匹配
  + -i 忽略大小
  + -n 显示行号
  + -r 递归搜索
  + -E 支持扩展正则表达式
  + -F 取消正则表达式
+ xargs 给命令传递参数的一个过滤器，也是组合多个命令的一个工具
```
find /sbin -perm +700 |ls -l       #这个命令是错误的
find /sbin -perm +700 |xargs ls -l   #这样才是正确的
```



  



