#!/bin/bash

sudo mkdir /spigot-build/

sudo chown vagrant:vagrant /spigot-build/

cd /spigot-build/

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar

git config --global --unset core.autocrlf

echo Not sure how long this will take, so sit back and relax.

sudo su vagrant -c "java -Xmx1500M -jar BuildTools.jar --rev 1.8.3"

if [ -e spigot-1.8.3.jar ]
then
	cp spigot-1.8.3.jar /minecraft/minecraft_server.jar
	cp spigot-1.8.3.jar /spigot/
	cp craftbukkit-1.8.3.jar /spigot/
	cp Spigot/Spigot-Server/pom.xml /spigot/spigot-pom.xml
	cp CraftBukkit/pom.sml /spigot/craftbukkit-pom.xml
else
	echo Failed to generate spigot!
	exit 404
fi

echo Initial install of spigot jars to maven.

mvn install:install-file -Dfile=spigot-1.8.3.jar -Dpackaging=jar -DpomFile=Spigot/Spigot-Server/pom.xml

mvn install:install-file -Dfile=craftbukkit-1.8.3.jar -Dpackaging=jar -DpomFile=CraftBukkit/pom.xml
