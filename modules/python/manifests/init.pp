class python {
    package {[
        'python-all-dev', 'python-dev', 'python3-dev', 'python-virtualenv', 'python3.6',
        'python-numpy',
    ]:
        ensure => latest,
    }

    exec {'trust douban certification':
        command => 'wget misc.douban.com/ca.crt -O douban.crt && update-ca-certificates',
        cwd     => '/usr/local/share/ca-certificates',
        onlyif  => 'test ! -f /usr/local/share/ca-certificates/douban.crt',
    }

    exec { 'ensure local pip installed':
        command => 'wget https://bootstrap.pypa.io/get-pip.py -O - | python',
        onlyif  => 'test ! -f /usr/local/bin/pip',
    }

    exec { 'ensure pip installed':
        command => 'ln -sf /usr/local/bin/pip /usr/bin/pip',
        onlyif  => 'test ! -L /usr/bin/pip',
        require => [
            Exec['ensure local pip installed'],
        ]
    }

    exec { 'ensure local pip3 installed':
        command => 'wget https://bootstrap.pypa.io/get-pip.py -O - | python3.6',
        onlyif  => 'test ! -f /usr/local/bin/pip3',
    }

    exec { 'ensure pip3 installed':
        command => 'ln -sf /usr/local/bin/pip3 /usr/bin/pip3',
        onlyif  => 'test ! -L /usr/bin/pip3',
        require => [
            Exec['ensure local pip3 installed'],
        ]
    }

    file {'/home/vagrant/.pip':
        ensure => directory,
        owner  => 'vagrant',
        group  => 'vagrant',
    } ->
    file { '/home/vagrant/.pip/pip.conf':
        ensure => present,
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/python/pip.conf',
    }

    package {'future 2':
      name     => "future",
      install_options => {'--trusted-host' => 'pypim.dapps.douban.com'},
      ensure   => present,
      provider => 'pip',
    }

    package {'future 3':
      name     => "future",
      install_options => {'--trusted-host' => 'pypim.dapps.douban.com'},
      ensure   => present,
      provider => 'pip3',
    }

}
