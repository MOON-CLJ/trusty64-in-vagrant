class local_repo($source = 'aliyun') {
    $update_script = "puppet:///modules/local_repo/update_repo.sh"

    $source_hosts = {
        aliyun => 'mirrors.aliyun.com',
    }

    apt::source { "${source_hosts[$source]}-${lsbdistcodename}":
      location => "http://${source_hosts[$source]}/ubuntu",
      key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
      repos    => 'main universe multiverse restricted',
    } ->

    apt::source { "${source_hosts[$source]}-${lsbdistcodename}-security":
      location => "http://${source_hosts[$source]}/ubuntu",
      key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
      repos    => 'main universe multiverse restricted',
      release  => "${lsbdistcodename}-security"
    } ->

    apt::source { "${source_hosts[$source]}-${lsbdistcodename}-updates":
      location => "http://${source_hosts[$source]}/ubuntu",
      key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
      repos    => 'main universe multiverse restricted',
      release  => "${lsbdistcodename}-updates"
    } ->

    apt::source { "${source_hosts[$source]}-${lsbdistcodename}-backports":
      location => "http://${source_hosts[$source]}/ubuntu",
      key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
      repos    => 'main universe multiverse restricted',
      release  => "${lsbdistcodename}-backports"
    }

    file {'mariadb_repo':
        owner  => root,
        group  => root,
        path   => '/etc/apt/sources.list.d/mariadb10.0.list',
        ensure => file,
        source => 'puppet:///modules/local_repo/mariadb10.0.list',
    }
    file {'puppetlabs_repo':
        owner  => root,
        group  => root,
        path   => '/etc/apt/sources.list.d/puppetlabs-pc1.list',
        ensure => file,
        source => 'puppet:///modules/local_repo/puppetlabs-pc1.list',
    }
    file {'llvm_repo':
        owner  => root,
        group  => root,
        path   => '/etc/apt/sources.list.d/llvm.list',
        ensure => file,
        source => 'puppet:///modules/local_repo/llvm.list',
    }

    file {'update_repo_script':
        owner  => root,
        group  => root,
        mode   => '0755',
        path   => '/etc/apt/update_repo.sh',
        ensure => file,
        source => $update_script,
    } ->
    exec {'update-pkg-index':
        command     => "/bin/bash -c '/etc/apt/update_repo.sh'",
        timeout     => 1800,
        unless      => "[ -f '/vagrant/dont-update-pkg-index' ]",
    }
    Exec['update-pkg-index'] -> Package <| |>

    file {'/etc/apt/apt.conf.d/00vagrantbox':
        owner   => root,
        group   => root,
        ensure  => file,
        content => template('local_repo/apt_conf.erb'),
    }
    File['/etc/apt/apt.conf.d/00vagrantbox'] -> Exec['update-pkg-index']
    File['/etc/apt/apt.conf.d/00vagrantbox'] -> Package <| |>
}
