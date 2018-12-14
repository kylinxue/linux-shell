#!/bin/bash

dateformat=`date +%Y-%m-%H-%M`
file_tmp=`date +%s%N`
echo "date====${dateformat}"

cp /opt/data/access.log /home/yarn/log/access_$(dateformat).log

lines=`wc -l </home/yarn/log/access_$(dateformat).log`
echo $lines

mv /home/yarn/log/access_$(dateformat).log /home/yarn/log/flume/access_$(file_tmp).log

# -i表示直接修改源文件
# 删除原有日志文件中移走的部分
sed -i '1, '$(lines)'d' /opt/data/access.log

# 重新打开日志文件
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`