# Devoted-vm puppet provisioning

## General architecture

While this is (for now) built around getting a devotedmc development environment going in vagrant, it's been built for some degree of flexibility by environment, so it could eventually be used to provision other environments (including prod). To that end, environment-specific configuration has been offloaded to environments/%{::environment}/data/nodes/%{::hostname}.yaml

Thus, for this vagrant development instance: [environments/vagrant/data/nodes/devotedmc.yaml](environments/vagrant/data/nodes/devotedmc.yaml)

Minecraft version, paths, and a few static URLs (for now) can be configured here -- any environment-specific configuration should be put in here.

## Puppet librarian and custom_modules

Puppet librarian expects a Puppetfile that specifies the modules to be installed into modules/ **Do not edit anything in modules/ -- it will be overwritten by puppet librarian.** Our custom modules are located in custom_modules and referenced in Puppetfile. Further modules can eventually be added to the Puppetfile.

There are currently two custom modules that do the bulk of the heavy lifting.

### javadev

1. Installs openjdk-8-jdk via the puppetlabs java module.

2. Installs some general java development packages, including maven.

### civcraft

Currently a relatively ugly puppet module to do the installation of spigot minecraft server:

1. Downloads and starts up base minecraft (version specified in hiera)

2. Downloads buildtools and builds a spigot server (buildtools URLs and paths specified in hiera)

3. Starts the minecraft server by way of a control.sh script that runs it in a screen session.

This is all done via an all-in-one dependency chain of puppet resources, which is really gross, but it works for now.


## TODO: 

* Eventually at least the civcraft module should be cleaned up and refactored into a standalone puppet module that handles setup of minecraft (preferrably by way of the puppetforge puppet-minecraft module), compilation of spigot, and installation of CivModCore.
* Fork off that civcraft module into a separate standalone repo, leaving the devoted-vm repo to be specifically the Vagrant development VM setup that just references that module.
* Build puppet module wrappers for other civcraft modules in use update hiera/documentation on how to incorporate.
