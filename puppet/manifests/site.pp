class dev {
  package { [
        'git', 'git-core', 'expect', 'vim'
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

node default {
  include tools

  include dev
}
