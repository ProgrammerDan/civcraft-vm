#!/bin/bash

sudo mkdir /spigot-build/

sudo chown vagrant:vagrant /spigot-build/

cd /spigot-build/

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar

git config --global --unset core.autocrlf

sudo su vagrant -c "java -Xmx1500M -jar BuildTools.jar --rev 1.8.3"

echo Not sure how long this will take, so sit back and relax.

if [ -e spigot-1.8.3.jar ]
then
	cp spigot-1.8.3.jar /minecraft/minecraft-server.jar
	cp *.jar /spigot/
else
	echo Failed to generate spigot!
	exit 404
fi
