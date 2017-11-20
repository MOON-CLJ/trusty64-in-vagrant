class vagrant () {
  stage { 'success':
    require => Stage[main],
  }

  class { 'vagrant::friendly_success_msg':
    stage => success,
  }

  class { timezone:
    zone => 'Asia/Shanghai',
  }

  package { ['linux-headers-generic']:
      ensure => latest,
  }

  file { '/etc/default/locale':
    ensure  => file,
    owner   => root,
    group   => root,
    content => 'LC_ALL=en_US.UTF-8',
  }
}
