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
        'vim-nox',
        'wget',
    ]:
        ensure => latest,
    }

    package { 'r10k':
        ensure   => 'installed',
        provider => 'gem',
    }

    vundle::installation { 'vagrant':
      plugins => [ 'Valloric/YouCompleteMe' ],
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
