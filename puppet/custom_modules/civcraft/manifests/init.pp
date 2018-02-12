class civcraft() {

  $minecraftpath        = hiera('devotedmc::civcraft::minecraftpath');
  $minecraftuser        = hiera('devotedmc::civcraft::minecraftuser');
  $spigotpath           = hiera('devotedmc::civcraft::spigotpath');
  $spigotbuildpath      = hiera('devotedmc::civcraft::spigotbuildpath');
  $spigotbuildtoolsurl  = hiera('devotedmc::civcraft::spigotbuildtoolsurl');
  $minecraftversion     = hiera('devotedmc::civcraft::minecraftversion');
  $minecraftserver      = hiera('devotedmc::civcraft::minecraftserver');

  file { $minecraftpath:
    ensure => directory
  } ->

  file { "${minecraftpath}/get_and_start_vanilla.sh":
    ensure  => file,
    owner   => $minecraftuser,
    group   => $minecraftuser,
    mode    => '0755',
    content => template('civcraft/get_and_start_vanilla.sh.erb'),
  } ->

    exec { 'civcraft.minecraftcreate':
      command => "${minecraftpath}/get_and_start_vanilla.sh",
      timeout => 0,
      unless  => "/usr/bin/test -f ${minecraftpath}/logs/latest.log"
    } ->


  file { $spigotpath:
    ensure => directory
    } ->

    file { $spigotbuildpath:
      ensure => directory
      } ->

    file { "${spigotpath}/get_and_build_spigot.sh":
      ensure  => file,
      owner   => $minecraftuser,
      group   => $minecraftuser,
      mode    => '0755',
      content => template('civcraft/get_and_build_spigot.sh.erb'),
    } ->
      exec { 'civcraft.spigotcreate':
        command   => "${spigotpath}/get_and_build_spigot.sh",
        timeout   => 0,
        logoutput => true,
        unless    => "/usr/bin/test -f ${spigotpath}/spigot-${minecraftversion}.jar"
      } ->

      file { "${minecraftpath}/control.sh":
        ensure  => file,
        owner   => $minecraftuser,
        group   => $minecraftuser,
        mode    => '0755',
        content => template('civcraft/control.sh.erb'),
        } ->

        exec { 'minecraft.start':
          command   => "${minecraftpath}/control.sh start",
          timeout   => 0,
          logoutput => true
          }

}
