class dev_tool {
    package {[
        'ack-grep',
        'build-essential',
        'software-properties-common',
        'curl',
        'git',
        'lsof',
        'strace',
        'tmux',
        'vim-nox',
        'wget',
    ]:
        ensure => latest,
    }

    file { '/usr/local/bin/ack':
        ensure  => link,
        target  => '/usr/bin/ack-grep',
        require => Package['ack-grep'],
    }

    file { '/etc/profile.d/default-editor.sh':
        require => Package['vim-nox'],
        owner   => root,
        group   => root,
        ensure  => file,
        source  => 'puppet:///modules/dev_tool/default-editor.sh',
    }

}
