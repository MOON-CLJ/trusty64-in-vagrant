class python {
    package {['python-all-dev', 'python-dev', 'python-virtualenv']:
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

    exec { 'update setuptools':
        command => '/usr/bin/pip install setuptools==28.8 --index-url https://pypi.doubanio.com/simple --trusted-host pypi.doubanio.com',
        onlyif  => '/usr/bin/pip search setuptools|grep -B 1 "INSTALLED: 28.8" ; test $? = 1',
        require => [
            Exec['ensure pip installed'],
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
}
