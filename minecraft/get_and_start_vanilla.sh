#!/bin/bash

wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8.4/minecraft_server.1.8.4.jar -O /minecraft/minecraft_server.jar

cd /minecraft

java -Xms1G -Xmx1G -jar minecraft_server.jar nogui

sed '$ c\
eula=true' -i eula.txt
