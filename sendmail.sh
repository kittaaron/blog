#!/bin/bash

#--------------------------------------------
# 监听服务器日志, 如果出现错误，发邮件告警
# author：kittaaron
# site: http://kittaaron:1888/static/index.html
#--------------------------------------------

cd `dirname $0`
logfile='logs/out_sports.log'
beforelinenum=`sed -n '$=' logs/out_sports.log`
echo $beforelinenum
echo "开始监听..."
secondspan=3
ip=`ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}'`
while true
do
  afterlinenum=`sed -n '$=' logs/out_sports.log`
  line=$(( $afterlinenum - $beforelinenum ))
  #echo "line:"$line
  beforelinenum=$afterlinenum
  content=`tail -n $line logs/out_sports.log |grep -A 20 'Exception'`
  if [ -n "$content" ]; then
    echo -e "服务器发生异常,准备发送告警邮件"
    echo -e $content  |  mail  -s  "服务器$ip 发生异常，请及时关注" -r liuhuiyu5201413@163.com 
    echo "发送邮件完成..."
  fi
  sleep $secondspan
done
echo "程序退出."
exit
