/*
 * https://github.com/uggedal/puppet-module-timezone
 */

class timezone($zone="UTC") {
  package { tzdata:
    ensure => present,
  }

  file { "/etc/timezone":
    content => inline_template('<%= @zone + "\n" %>'),
  }

  exec { "reconfigure-tzdata":
    command => "dpkg-reconfigure -f noninteractive tzdata",
    subscribe => File["/etc/timezone"],
    require => File["/etc/timezone"],
    refreshonly => true,
  }
}
