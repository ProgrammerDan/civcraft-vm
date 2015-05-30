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

