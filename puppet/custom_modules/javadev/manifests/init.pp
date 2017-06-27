class javadev {

  package { [
    'openjdk-6-jdk', 'openjdk-6-jre'
  ]:
    ensure => absent
  } ->

  class { 'java' :
    package => 'openjdk-8-jdk',
  }

  package { [
    'git', 'git-core', 'expect', 'vim', 'screen',
    'nano', 'maven'
  ]:
    ensure => latest
  }


}
