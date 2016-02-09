#!/bin/bash

cd /minecraft

if [[ "$1" == "start" ]]
then
	if [ -e '.mc_screen' ]
	then
		echo Minecraft is already in a screen session, joining to it now...
		sleep 3
		screen 
	else
		screen -d -S mc_screen -m -p 0 bash -c 'java -Xmx1500M -Xms500M -XX:MaxPermSize=256M -jar minecraft_server.jar nogui'
		touch .mc_screen
	fi
elif [[ "$1" == "stop" ]]
then 
	if [ -e '.mc_screen' ]
	then
		screen -S mc_screen -p 0 -X stuff 'stop
'
		rm .mc_screen
	else
		echo Minecraft seems to already be stopped?
	fi
fi
