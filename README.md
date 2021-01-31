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
      $$ 脚本本身的进程id
      $0 脚本本身
      $? 函数返回值
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
  ```
    for i in {1..20}
  do
    if [ $i == 10 ]; then
      break
    else
      echo $i
    fi
  done > echo.txt
  ```
## 常用命令
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
      + -print 打印输出 （默认选项）
      + -exec 接命令 (查到test目录，删除所有)
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
+ egrep 相当于 grep -E
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

+ sed 流编辑器
+ man sed （说明）
+ 第一种形式: stdout | sed [option] "pattern command"
+ 第二种形式: sed[option] "pattern command" file
+ 选项
  + -n 只打印模式匹配行
  + -e 允许同一行支持多条命令
  + -f 编辑动作保存在文件中，指定文件执行
  + -r 支持扩展正则表达式
  + -i 直接修改文件内容
+ pattern 模式
  + /pattern1/ --- 匹配到pattern1开始的所有内容 （常用）

  ```
    sed -n "/^ftp/p" file 打印file文件中第一个匹配到以ftp开头的行的所有内容
  ```

  + /pattern1/,/pattern2/ --- 匹配到pattern1开始到 匹配到pattern2 （常用）

  ```
  sed -n "/^ftp/,/^mail/p" file 打印file文件中第一个匹配到以ftp开头的行，到mail结束的内容
  ```

+ command 参数
  + p 打印
  + d 删除
  + 增加
    + a   --- 匹配到的行后追加内容
    + i   --- 匹配到的行前追加内容
    + r   --- 将外部文件的内容追加到匹配到的行后面
    + w   --- 将匹配到的行内容另存到其他文件中
  + 修改
    + s/pattern/string/ ----查找并替换符合pattern模式的字符串 （默认只替换第一个）
    + s/pattern/string/g ----查找并替换符合pattern模式的字符串 （表示全部行全部替换）
    + s/pattern/string/ig ----查找并替换符合pattern模式的字符串 （表示全部行全部替换，不分大小写）
    + s/pattern/string/2g ----查找并替换符合pattern模式的字符串 （表示替换从第2个开始，往后所有的）
    + s/pattern/string/2 ----查找并替换符合pattern模式的字符串 （表示替换前两个）
  + 其他命令
    + = 显示行号
    ```
      sed -n '/aaa/='  显示匹配 aaa 的行号为多少 (centos)
      sed -n '' '/aaa/='  显示匹配 aaa 的行号为多少 (mac)
      mac 和 centos下差异文档： https://blog.csdn.net/u011138533/article/details/52574144
    ```
  + 反向引用
    + &s 和 \1 (相同，\1更灵活)
    ```
    sed -i 's/\(a..b\)/\1bp/g' 匹配axxb这种形式（aQQb|aWWb|aEEb|...）匹配成aQQbp|aWWbp|aEEbp|..
    ```
    ```
    sed -i 's/\(a\)../\1bp/g' 匹配axxb这种形式（aQQ|aWW|aEE|...）匹配成abp|abp|abp|..
    ```
  + 注意事项： 在匹配模式中如果使用变量，要用双引号-> 例子 examples/example/sed1.sh


  + awk 文本分析工具
    + -v 可以引入shell中的变量
    ```
      awk -v pid1=$1 -v pid2=$2 "pid==1023"
    ```
  + 内置变量
    + $0 整行内容
    + $1 - $n 当前行第1-n个字段
    + NF 当前行的字段个数
    + NR 当前行的行号
    + FS 输入字段分隔符。 默认空格或者tab键
    + RS 输入行分割符号。 默认回车
    + OFS 输出字段分隔符。 默认为空格
    + ORS 输出行分割符号。 默认回车
  + printf 格式化输出
    + 格式符
      + %s 打印字符串
      + %d 打印10进制
      + %f 打印浮点数
      + %x 打印16进制
      + %0 打印8进制
    + 修饰符
      + - 左对齐
      + + 右对齐
  + 两种匹配模式
    + 1、RegExp
      ```
        awk 'BEGIN{FS=":"}/test/{print $0}' test3.txt
      ```
    + 2、关系运算符号
      + < 小于
      + > 大于
      + != 不等于
      + ~ 匹配正则表达式
      + !~ 不匹配正则表达式
      + && || ! 与或非
      ```
        awk 'BEGIN{FS=":"}$3<50{print $0}' test3.txt
      ```
  + 算术运算符 (例子: test4.awk)
    + ++x 返回前先加1
    + x-- 返回后减1
    + 同理、、、省略。。
  + 循环语句
    + for 循环 (例子: test5.awk -> 统计每行的总计)
      ```
        for(初始化计数器;计数器测试;计数器变更)
        动作
      ```
  + 数组 例子: test6.awk  -> 统计偶数并相加)
    ```
      for (a in array)
    ```
### 脚本实战中比较常用的关键字
  + shift 参数左移
    ```
      sh xxx.sh -g DB
      如果脚本中有 shift
      相当于命令为
      sh xxx.sh DB
    ```
  + NF 当前行的字段个数
  + NR 当前行的行号
  + $$ 脚本本身的进程id
  + $0 脚本本身
  + $? 函数返回值 (高频)
  + $@ 获取所有参数
### 模拟一个进程管理工具
  + 在 /examples/example6目录下
  
  





  



