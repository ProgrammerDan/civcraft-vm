class dev {
  package { [
        'git', 'git-core', 'expect', 'vim', 'screen', 
		'pico', 'openjdk-7-jdk'
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
	exec { 'civcraft.foldercreate':
	  command => '/usr/bin/sudo /minecraft'
	}
	exec { 'civcraft.folderchown':
	  require => Exec['civcraft.foldercreate'],
	  command => '/usr/bin/sudo chown vagrant:vagrant /minecraft'
	}
}

node default {
  include tools

  include dev
}
