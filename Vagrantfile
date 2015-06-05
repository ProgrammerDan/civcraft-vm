# -*- mode: ruby -*-
# vi: set ft=ruby :

#If api.puppetlabs.com is down or otherwise unreachable, everything will break.
#There is no workaround currently in place.
$puppet_update_script  = <<SCRIPT
cd /tmp
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
if [ $(puppet --version) != '3.3.1' ]
  then
    sudo apt-get remove puppet -y
    sudo apt-get install puppet -y
fi
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "plab"
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 25565, host: 25565

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  config.vm.provision :shell, :inline => $puppet_update_script
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  guest_puppet_lib = "/tmp/puppet_lib/"
  host_puppet_lib = "./puppet/"
  config.vm.synced_folder host_puppet_lib, guest_puppet_lib
  config.vm.synced_folder ".", "/home/vagrant/host"
  config.vm.synced_folder "./minecraft", "/minecraft"
  config.vm.synced_folder "./spigot", "/spigot"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
    # Use VBoxManage to customize the VM. For example to change memory:
	vb.memory = 2048
    vb.name = "civcraft" 
    ext_filename = "ext.vdi"
	if ARGV[0] == "up" && ! File.exist?(ext_filename)
      vb.customize ["createhd", "--filename", ext_filename, "--size", "51200"] #51200 = 50*1024, ie 50 GB
      vb.customize ["storageattach", vb.name, "--storagectl", "SATA Controller", "--port", "1", "--type", "hdd", "--medium", ext_filename]
	end
  end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  modulepath = guest_puppet_lib + 'modules:' + guest_puppet_lib + 'third-party'
  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose --debug --parser future --modulepath=" + modulepath
    puppet.manifests_path = host_puppet_lib + "manifests"
    puppet.manifest_file  = "site.pp"
  end
end
