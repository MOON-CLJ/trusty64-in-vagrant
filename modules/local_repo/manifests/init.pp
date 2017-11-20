class local_repo($source = 'aliyun') {
    $repo_conf = "puppet:///modules/local_repo/sources.list.${source}"
    $update_script = "puppet:///modules/local_repo/update_repo.sh"

    $source_hosts = {
        aliyun => 'mirrors.aliyun.com',
    }

    file {'local_repo':
        owner  => root,
        group  => root,
        path   => '/etc/apt/sources.list',
        ensure => file,
        source => $repo_conf,
    } ->
    file {'puppetlabs_repo':
        owner  => root,
        group  => root,
        path   => '/etc/apt/sources.list.d/puppetlabs-pc1.list',
        ensure => file,
        source => 'puppet:///modules/local_repo/puppetlabs-pc1.list',
    } ->
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
    Exec['update-pkg-index'] <- Ubuntu::Ppa_repo <| |>

    $apt_conf = 'puppet:///modules/local_repo/apt_conf'
    $proxied_hosts = [
        $source_hosts[$source],
        'ppa.launchpad.net',
    ]
    file {'/etc/apt/apt.conf.d/00vagrantbox':
        owner   => root,
        group   => root,
        ensure  => file,
        content => template('local_repo/apt_conf.erb'),
    }
    File['/etc/apt/apt.conf.d/00vagrantbox'] -> Exec['update-pkg-index']
    File['/etc/apt/apt.conf.d/00vagrantbox'] -> Package <| |>
}
