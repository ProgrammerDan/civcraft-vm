#!/bin/bash

cd /spigot/

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar

git config --global --unset core.autocrlf

sudo su vagrant -c "java -jar BuildTools.jar --rev 1.8.3"

echo Not sure how long this will take, so sit back and relax.

if [ -e spigot-1.8.3.jar ]
then
	cp spigot-1.8.3.jar /minecraft/minecraft-server.jar
else
	echo Failed to generate spigot!
	exit 404
fi
