Exec {
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    logoutput => on_failure,
}

include vagrant
include users::z_group
include users::clj
include apt

apt::key { 'mariadb':
    id     => '199369E5404BD5FC7D2FE43BCBCB082A1BB943DB',
    server => 'keyserver.ubuntu.com',
}

apt::key { 'llvm':
    id     => '6084F3CF814B57C1CF12EFD515CF4D18AF4F7421',
    server => 'keyserver.ubuntu.com',
}

apt::ppa { 'ppa:jonathonf/vim': }
apt::ppa { 'ppa:jonathonf/python-3.6': }
apt::ppa { 'ppa:gophers/archive': }
apt::ppa { 'ppa:ubuntu-toolchain-r/test': }

class { local_repo:
    source => 'aliyun',
}

include infrastructure
include dev_tool
