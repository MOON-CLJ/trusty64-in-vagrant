class dev_tool {
    package {[
        'puppetserver',
        'ack-grep',
        'build-essential',
        'software-properties-common',
        'curl',
        'git',
        'lsof',
        'strace',
        'tmux',
        'vim',
        'wget',
        'fish',
        'htop',
        'memcached',
        'libmemcached10',
        'redis-server',
        'libsnappy-dev',
        'libssl-dev',
        'valgrind',
        'cppcheck',
        'cmake',
        'subversion',
        'clang-4.0',
        'lldb-4.0',
        'clang-tidy',
    ]:
        ensure => latest,
    }

    package { 'r10k':
        ensure   => 'installed',
        provider => 'gem',
    }

    file { '/usr/local/bin/ack':
        ensure  => link,
        target  => '/usr/bin/ack-grep',
        require => Package['ack-grep'],
    }

    file { '/etc/profile.d/default-editor.sh':
        require => Package['vim'],
        owner   => root,
        group   => root,
        ensure  => file,
        source  => 'puppet:///modules/dev_tool/default-editor.sh',
    }

}
