# civcraft-vm
Virtual Machine appliance using Vagrant and puppet to auto provision a Civcraft-compatible testing machine

My target for this is to get as far along the path to having a working, running Civcraft server at the end of the script as possible. This is pretty ambitious, so what is more likely is:

1. Basic VM provisioning

2. Java and other dependency installations (git, maven)

3. Minecraft server install

4. Minecraft server startup

5. Spigot server download

6. Spigot server replace Minecraft

7. Spigot server execution

with the core mods being in the hands of the developer.

I'll likely also add here *first* some how-tos in terms of getting mods set up that play nice with the server, and will submit refined versions to go in Dr_Jawa and/or Erocs' guides.

--------------------------


## How to use this appliance

1. Get Vagrant: https://www.vagrantup.com/downloads.html

2. Get VirtualBox: http://download.virtualbox.org/virtualbox/
   (check LATEST.TXT for which to download)

3. Install Vagrant (may require restart)

4. Install VirtualBox (will disconnect your internet, so log off Civcraft)

5. Clone this repository locally: git clone git@github.com:ProgrammerDan/civcraft-vm.git

6. cd into that repository: cd civcraft-vm

7. Issue vagrant up

8. SSH into vagrant: vagrant@127.0.0.1:2222 default password vagrant

9. Until automated, seek out other resources for setting up Civcraft.

----------------------

## Setting up Civcraft in your new VM

1. sudo apt-get install openjdk-7-jdk

2. sudo mkdir /minecraft

3. sudo chown vagrant:vagrant /minecraft

4. cd /minecraft

5. wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8.4/minecraft_server.1.8.4.jar

6. java -Xms1G -Xmx1G -jar minecraft_server.1.8.4.jar nogui

7. Server startup will fail. Edit the eula.txt last line, change it to "eula=true"

8. sudo java -Xms1G -Xmx1G -jar minecraft_server.1.8.4.jar nogui

9. Wait for the server world generation to complete.

10. Now, test your server by connecting to it: localhost:25565

Note: If you need to restart your Vagrant for any reason, issue "vagrant reload" at the host terminal.
