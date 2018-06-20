class users::z_group {
    group { 'group z':
        name   => "z",
        gid    => "222",
        ensure => "present",
    }
}

class users::clj {
    file { '/home/clj':
        ensure  => 'directory',
        replace => false,
        owner   => 'clj',
        group   => 'z',
    }

    user { 'user clj':
        ensure     => present,
        name       => 'clj',
        groups     => ['z', 'vagrant'],
        home       => '/home/clj',
        uid        => '501',
        gid        => 'z',
        managehome => true,
        shell      => '/usr/bin/fish',
    }

    file { '/home/clj/.bash_aliases':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.bash_aliases',
    }

    file { '/home/clj/.gitconfig':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.gitconfig',
    }

    file { '/home/clj/.gitignore':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.gitignore',
    }

    file { '/home/clj/.tmux.conf':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.tmux.conf',
    }

    file { '/home/clj/.vimrc':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.vimrc',
    }

    file { '/home/clj/.ackrc':
        owner  => 'clj',
        group  => 'z',
        source => 'puppet:///modules/users/.ackrc',
    }
}

class users::vagrant {
    file { '/home/vagrant/.bash_aliases':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.bash_aliases',
    }

    file { '/home/vagrant/.gitconfig':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.gitconfig',
    }

    file { '/home/vagrant/.gitignore':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.gitignore',
    }

    file { '/home/vagrant/.tmux.conf':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.tmux.conf',
    }

    file { '/home/vagrant/.vimrc':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.vimrc',
    }

    file { '/home/vagrant/.ackrc':
        owner  => 'vagrant',
        group  => 'vagrant',
        source => 'puppet:///modules/users/.ackrc',
    }
}
