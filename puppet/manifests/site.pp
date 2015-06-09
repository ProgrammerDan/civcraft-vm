class dev {
  package { [
        'git', 'git-core', 'expect', 'vim', 'screen', 
        'nano', 'openjdk-7-jdk', 'maven'
    ]:
    ensure => latest
  }
  package { [
        'openjdk-6-jdk', 'openjdk-6-jre'
    ]:
    ensure => absent
  }
  exec { 'dev.rightjdk':
    require => Package['openjdk-7-jdk'],
	path => ["/usr/bin/", "/usr/sbin/", "/bin"],
    command => 'update-java-alternatives -s java-1.7.0*'
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
    command => '/minecraft/get_and_start_vanilla.sh',
    timeout => 0
  }
  file { 'civcraft.spscript':
    require => Exec['civcraft.minecraftcreate'],
    path => '/spigot/get_and_build_spigot.sh',
    ensure => file,
    mode => '0775'
  }
  exec { 'civcraft.spigotcreate':
    require => File['civcraft.spscript'],
    command => '/spigot/get_and_build_spigot.sh',
    timeout => 0,
    logoutput => true
  }
  file { 'civcraft.spigotcontrol':
    require => Exec['civcraft.spigotcreate'],
    path => '/minecraft/control.sh',
    ensure => file,
    mode => '0775'
  }
  exec { 'civcraft.spigotserver':
    require => File['civcraft.spigotcontrol'],
    command => '/minecraft/control.sh start',
    timeout => 0, 
    logoutput => true
  }
}

class civcraftdev {
  require civcraft
  exec { 'civcraftdev.prep_all':
    command => 'cp /civcraft_dev/*.sh /civcraft_build/'
  }
  file { 'civcraftdev.namelayer':
    require => Exec['civcraftdev.prep_all'],
    path => '/civcraft_build/namelayer-git.sh',
    ensure => file,
    mode => '0775'
  }
}

node default {
  include dev

  include civcraft
}
