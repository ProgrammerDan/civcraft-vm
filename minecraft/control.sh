#!/bin/bash

echo based on command and PID and screen control minecraft
echo but for now just do a dumb switch with Screen based controls

cd /minecraft

if [ $1 == 'start' ]
then
	if [ -e '.mc_screen' ]
	then
		echo Minecraft is already in a screen session, joining to it now...
		sleep 3
		screen 
	screen -d -m bash -c 'java -Xmx1500M -Xms500M -XX:MaxPermSize=256M -jar minecraft_server.jar nogui'
