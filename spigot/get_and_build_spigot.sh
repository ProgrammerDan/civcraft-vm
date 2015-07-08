#!/bin/bash

sudo mkdir /spigot-build/

sudo chown vagrant:vagrant /spigot-build/

cd /spigot-build/

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar

git config --global --unset core.autocrlf

echo Not sure how long this will take, so sit back and relax.

sudo su vagrant -c "java -Xmx1500M -jar BuildTools.jar --rev 1.8.7"

if [ -e spigot-1.8.7.jar ]
then
	cp spigot-1.8.7.jar /minecraft/minecraft_server.jar
	cp spigot-1.8.7.jar /spigot/
	cp craftbukkit-1.8.7.jar /spigot/
else
	echo Failed to generate spigot!
	exit 404
fi

echo Initial install of spigot jars to maven.

mvn install:install-file -Dfile=spigot-1.8.7.jar -DgroupId=org.spigotmc -DartifactId=spigot -Dversion=1.8.7 -Dpackaging=jar

mvn install:install-file -Dfile=craftbukkit-1.8.7.jar -DgroupId=org.bukkit -DartifactId=craftbukkit -Dversion=1.8.7 -Dpackaging=jar
