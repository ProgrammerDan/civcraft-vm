class dev {
  package { [
        'git', 'git-core', 'expect', 'vim', 'screen', 
		'nano', 'openjdk-7-jdk'
    ]:
    ensure => latest
  }
}

class tools {
  exec { 'tmux.apt-add-repository':
    command => '/usr/bin/sudo /usr/bin/apt-add-repository -y ppa:pi-rho/dev'
  }
  exec { 'tmux.apt-update':
    require => Exec['tmux.apt-add-repository'],
    command => '/usr/bin/sudo /usr/bin/apt-get update'
  }
  exec { 'tmux.install':
    require => Exec['tmux.apt-update'],
    command => '/usr/bin/sudo /usr/bin/apt-get -y install tmux=1.9a-1~ppa1~p'
  }
  package{ ['python-software-properties', 'software-properties-common']:
    ensure => latest
  }
}

class civcraft {
  require dev
  file { 'civcraft.mcscript':
    path => '/minecraft/get_and_start_vanilla.sh',
    ensure => file,
    mode => '0775'
  }
  exec { 'civcraft.minecraftcreate':
    require => File['civcraft.mcscript'],
    command => '/minecraft/get_and_start_vanilla.sh'
  }
  file { 'civcraft.spscript':
    require => Exec['civcraft.minecraftcreate'],
    path => '/spigot/get_and_build_spigot.sh',
    ensure => file,
    mode => '0775'
  }
  exec { 'civcraft.spigotcreate':
    require => File['civcraft.spscript'],
    command => '/spigot/get_and_build_spigot.sh'
  }
}

node default {
  include tools

  include dev

  include civcraft
}
