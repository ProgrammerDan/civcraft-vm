#!/bin/bash

wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8.4/minecraft_server.1.8.4.jar -O /minecraft/minecraft_server.jar

cd /minecraft

java -Xms500M -Xmx1G -jar minecraft_server.jar nogui

sed '$ c\
eula=true' -i eula.txt

java -Xms500M -Xmx1G -jar minecraft_server.jar nogui &

echo Going to give MC some time to get situated.

sleep 30

if [ -e ops.json ]
then
	echo 'Making progress, ops file exists'
fi

sleep 30

if [ -d world ]
then
	echo 'World folder in place, great!'
fi

sleep 30

if [ -e logs/latest.log ]
then
	echo 'Logs in place, good, most recent logs:'
	tail logs/latest.log
fi

sleep 30

echo We have waited long enough, killing the process.

kill -15 %1

sleep 30

echo Ok, let's move on.
