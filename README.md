# civcraft-vm
Virtual Machine appliance using Vagrant and puppet to auto provision a Civcraft-compatible testing machine

---------

**DISCLAIMER:** Use of this VM appliance indicates you agree with Minecraft's EULA! If you don't, or don't know what I'm talking about, don't use this VM appliance until you do, and can agree with it.

----------------

My target for this is to get as far along the path to having a working, running Civcraft server at the end of the script as possible. What I have so far:

1. Basic VM provisioning

2. Java and other dependency installations (git, maven)

3. Minecraft server install

4. Minecraft server startup

5. Spigot server download

6. Spigot server replace Minecraft

with the core mods being in the hands of the developer -- for now. That's next.

I'll likely also add here *first* some how-tos in terms of getting mods set up that play nice with the server, and will submit refined versions to go in Dr_Jawa and/or Erocs' guides.

--------------------------

## How to use this appliance

1. Get git: https://git-scm.com/downloads

2. Get Vagrant: https://www.vagrantup.com/downloads.html

3. Get VirtualBox: http://download.virtualbox.org/virtualbox/

    * (check LATEST.TXT for which to download)
	
	* Note that if you are running Windows 8, be warned that installing VirtualBox's bridge adapter may [break standby and Windows 8 Fast Shutdown](http://www.reddit.com/r/Civcraft/comments/38nrd2/morning_changelog_20150605/crwvoqc).

4. Install git (or one of the many GUI clients, ya wuss)

5. Install Vagrant (may require restart)

6. Install VirtualBox (will disconnect your internet, so log off Civcraft)

7. Clone this repository locally: `git clone git@github.com:ProgrammerDan/civcraft-vm.git`

8. cd into that repository: cd civcraft-vm

9. Issue `vagrant up`. Note, this will take *a long time* so go do other things while waiting.

10. SSH into vagrant: `vagrant@127.0.0.1:2222` default password `vagrant`

11. Until automated, seek out other resources for setting up Civcraft.

----------------------

## Setting up Civcraft in your new VM

1. The puppet provisioning issued by Vagrant (don't worry about the details) will handle most of the setup.

    1. Minecraft 1.8.3 will be properly initialized

    2. EULA will be accepted -- **if you object to this, don't use this VM.**

    3. Spigot 1.8.3 will be built locally using BuildTools

    4. Spigot will be installed as the minecraft_server.jar

    5. Vanilla MC to Spigot conversion will occur.

2. Now, test your server by connecting to it: localhost:25565

Note: If you need to restart your Vagrant for any reason, issue "vagrant reload" at the host terminal.

3. Proceed into installing Civcraft server mods.

--------------------

## Setting up your host machine as a development environment

1. Install Maven: https://maven.apache.org/download.cgi

2. Install a Java Development Environment

    * Eclipse is good: https://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/lunasr2

    * IntelliJ is good: https://www.jetbrains.com/idea/download/

    * Hardcore? Notepad++ is popular: https://notepad-plus-plus.org/download/

    * Textpad is a good hardcore for Windows: http://www.textpad.com/download/

    * Badass? Vim: http://www.vim.org/download.php or Emacs: http://www.gnu.org/software/emacs/#Obtaining

3. Install git if you haven't already: https://git-scm.com/downloads

4. Install spigot & craftbukkit into your maven repository:

    mvn install:install-file -Dfile=./spigot/spigot-1.8.3.jar -DgroupId=org.spigotmc -DartifactId=spigot -Dversion=1.8.3 -Dpackaging=jar -DpomFile=./spigot/spigot-pom.xml

    mvn install:install-file -Dfile=./spigot/craftbukkit-1.8.3.jar -DgroupId=org.bukkit -DartifactId=craftbukkit -Dversion=1.8.3 -Dpackaging=jar -DpomFile=./spigot/craftbukkit-pom.xml

--------------------

## Setting up the VM as a development environment

Already done! Unlike your local machine, the dev environment has already installed spigot and craftbukkit compiled artifacts into the Maven repository, so you're ready to start developing out of the box.

--------------------

## Post set-up in either case

1. Check out your favorite Civcraft mod and start hacking: https://github.com/Civcraft/

2. Most of them are "good" mods and after cloning them locally you can issue: 

    * `mvn clean package "-Dbuild.number=Local"`

    * That builds the mod, and puts the output jar in ./target off the repository root.

    *  The build.number stuff just gives a meaningful assignment to the incremental build number in the POM (maven details, go read up on it).

3. Drop the built jars into the vm's `/minecraft` folder and restart the minecraft server on the VM.
