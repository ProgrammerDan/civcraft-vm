# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :devotedmc, autostart: true do |devotedmc_config|
    devotedmc_config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
    devotedmc_config.vm.host_name = 'devotedmc.local'
    devotedmc_config.vm.host_name = 'devotedmc.local'

    devotedmc_config.vm.provider "virtualbox" do |v|
      v.memory = 3072
      v.cpus = 1
      v.name = "devotedmc.local"
      ext_filename = "ext3.vdi"
      if ARGV[0] == "up" && ! File.exist?(ext_filename)
        v.customize ["createhd", "--filename", ext_filename, "--size", "51200"] #51200 = 50*1024, ie 50 GB
      end
      v.customize ["storageattach", v.name, "--storagectl", "IDE Controller", "--port", "1", "--type", "hdd", "--medium", ext_filename, "--device", "0"]
    end

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    devotedmc_config.vm.network :forwarded_port, guest: 25565, host: 25565

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    devotedmc_config.vm.network :private_network, ip: "192.168.33.10"
    devotedmc_config.vm.boot_timeout = 600

    devotedmc_config.vm.synced_folder "puppet", "/srv/puppet", mount_options: ["dmode=777", "fmode=666"]
    #devotedmc_config.vm.synced_folder "./minecraft", "/minecraft"
    #devotedmc_config.vm.synced_folder "./spigot", "/spigot"

    devotedmc_config.librarian_puppet.puppetfile_dir = "puppet"
    devotedmc_config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
    devotedmc_config.librarian_puppet.use_v1_api  = '3' # Check https://github.com/rodjek/librarian-puppet#how-to-use
    devotedmc_config.librarian_puppet.destructive = false # Check https://github.com/rodjek/librarian-puppet#how-to-use

    devotedmc_config.vm.provision :shell do |shell|
      #shell.inline = "wget -O - https://raw.githubusercontent.com/petems/puppet-install-shell/master/install_puppet.sh | sudo sh"
      shell.inline = "if [ ! -f /opt/puppetlabs/bin/puppet ]; then wget -O - https://raw.githubusercontent.com/petems/puppet-install-shell/master/install_puppet_agent.sh | sudo sh; fi ; apt-get update;"
    end

    devotedmc_config.vm.provision :puppet do |puppet|
      puppet.environment = "vagrant"
      puppet.environment_path = "puppet/environments"
      puppet.module_path = "puppet/modules/"
      puppet.manifests_path = "puppet/manifests/"
      puppet.manifest_file = "vagrant.pp"
      puppet.hiera_config_path = "puppet/environments/vagrant/hiera.yaml"
      puppet.options = "--verbose --debug"
    end
  end


end
