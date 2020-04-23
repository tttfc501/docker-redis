#!/bin/bash
#判断conf文件是否包含需要插入的配置，没有则插入
#初始化参数和conf文件
addText=("replica-announce-ip $ANNOUNCE_IP" "replica-announce-port $ANNOUNCE_PORT")
confFile='/etc/redis/redis.conf'
#判断配置是否存在，不存在则插入
for (( i = 0; i < ${#addText[@]}; i++ ))
do
 	if ! grep "${addText[$i]}" $confFile  > /dev/null
	then
		echo "${addText[$i]}" >> $confFile
	fi
done
#启动redis
if [ $ISSLAVE == 1 ]; then
  redis-server $confFile --slaveof redis-master 6379
else
  redis-server $confFile
fi