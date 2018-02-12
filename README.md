# Devoted-vm
Virtual Machine appliance using Vagrant and puppet to auto provision a Devoted-compatible testing machine

---------

**DISCLAIMER:** Use of this VM appliance indicates you agree with Minecraft's EULA! If you don't, or don't know what I'm talking about, don't use this VM appliance until you do, and can agree with it.

(Fuck Microsoft. Fuck the EULA. I don't want Minecraft 2 @MS Execs)

----------------

This setup takes care of the following:

1. Basic VM provisioning

2. Java development environment (via a "javadev" puppet module)

3. Spigot minecraft build

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

6. Install VirtualBox (will disconnect your internet, so log off Devoted)

7. Install puppet: https://downloads.puppetlabs.com/

8. Install rubygems (if you don't already have it)

9. Install librarian-puppet: `gem install librarian-puppet`

10. Install the vagrant librarian-puppet plugin (https://github.com/voxpupuli/vagrant-librarian-puppet): vagrant plugin install vagrant-librarian-puppet

11. Clone this repository locally: `git clone git@github.com:DevotedMC/devoted-vm.git`

12. cd into that repository: cd devoted-vm

13. Issue `vagrant up`. Note, this will take *a long time* so go do other things while waiting.

14. SSH into vagrant: `vagrant@127.0.0.1:2222` default password `vagrant`

15. Until automated, seek out other resources for setting up Devoted.

----------------------

## Setting up Devoted in your new VM

1. The puppet provisioning issued by Vagrant (don't worry about the details) will handle most of the setup.

    1. Review the default versions and paths in [puppet/environments/vagrant/data/nodes/devotedmc.yaml](puppet/environments/vagrant/data/nodes/devotedmc.yaml) and change if desired. See the [puppet provisioning documentation](puppet/README.md) for specifics on how this is currently implemented.

    2. Minecraft 1.10.2 will be properly initialized

    3. EULA will be accepted -- **if you object to this, don't use this VM.**

    4. Spigot 1.10.2 will be built locally using BuildTools

    5. Spigot will be installed as the minecraft_server.jar

    6. Vanilla MC to Spigot conversion will occur.

2. Now, test your server by connecting to it: localhost:25565

Note: If you need to restart your Vagrant for any reason, issue "vagrant reload" at the host terminal.

3. Proceed into installing Devoted server mods.

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

    mvn install:install-file -Dfile=./spigot/spigot-1.8.7.jar -DgroupId=org.spigotmc -DartifactId=spigot -Dversion=1.8.7 -Dpackaging=jar -DpomFile=./spigot/spigot-pom.xml

    mvn install:install-file -Dfile=./spigot/craftbukkit-1.8.7.jar -DgroupId=org.bukkit -DartifactId=craftbukkit -Dversion=1.8.7 -Dpackaging=jar -DpomFile=./spigot/craftbukkit-pom.xml

--------------------

## Setting up the VM as a development environment

Already done! Unlike your local machine, the dev environment has already installed spigot and craftbukkit compiled artifacts into the Maven repository, so you're ready to start developing out of the box.

--------------------

## Post set-up in either case

1. Check out your favorite Devoted mod and start hacking: https://github.com/DevotedMC/

2. Most of them are "good" mods and after cloning them locally you can issue: 

    * `mvn clean package "-Dbuild.number=Local"`

    * That builds the mod, and puts the output jar in ./target off the repository root.

    *  The build.number stuff just gives a meaningful assignment to the incremental build number in the POM (maven details, go read up on it).

3. Drop the built jars into the vm's `/minecraft/plugins` folder and restart the minecraft server on the VM.

-----------------

## Devoted Clone TODO

Note that currently, Namelayer and Citadel are in constant flux as Rourke and team work on Mercury / Sharding. The following is a stable plugin set:

    CivModCore 1.0.3

    NameLayer 2.3.5-136

    Citadel 3.2.8-130

If you want to contribute to these plugins, you're going to need to go to most recent version on the plugin's master branch; I'll help you as I can.

### CivModCore Setup (1.0.3)

1. Grab the latest CivModCore jar from the Civcraft build server, or build locally

2. Put the jar into `/minecraft/plugins`

3. Continue.


### Namelayer Setup (2.3.5-136)

1. Grab the latest jar from Civcraft build server, or build locally (links, can we also get Github releases for devotedbuilds?)

2. Put the jar into `/minecraft/plugins`

3. Start the server, observe the errors

4. Shut down the server.

5. Open `/minecraft/plugins/Namelayer/config.yml` -- note the need for username and password

6. Install mysql -- `sudo apt-get install mysql-server`

    * It's up to you if you want to set a root password; if you don't you'll be asked a bunch of times.

7. Log in to mysql -- `mysql -uroot -p` with whatever password you set, or omit the `-p` if you did not set one.

8. Create namelayer credentials -- `CREATE USER mc_namelayer IDENTIFIED BY 'minecraft';` -- clearly not high security here.

9. Create a database for this user -- `CREATE DATABASE IF NOT EXISTS namelayer`

10. Give permission to use the database to your user -- `GRANT ALL ON namelayer.* TO mc_namelayer`

11. `exit` the mysql shell.

12. Test your user and database -- `mysql namelayer -umc_namelayer -p` entering in password `minecraft` -- if this gives no errors, you're ready to go.

13. Go back to `/minecraft/plugins/Namelayer/config.yml` and edit it to look like this:

    sql:
	  hostname: localhost
	  port: 3306
	  dbname: namelayer
	  username: 'mc_namelayer'
	  password: 'minecraft'
	groups:
	  enable: true

14. Restart the spigot server.

15. If there are tons of errors, let me know. Any such things are on my to-do to fix this.

16. Stop and restart spigot one last time.

### Citadel Setup (3.2.8-130)

1. If Namelayer is installed, just grab the latest jar from Civcraft build server, or build locally

2. Put the jar into `/minecraft/plugins`

3. Start the server, observe the errors

### Humbug Setup

### FactoryMod Setup
