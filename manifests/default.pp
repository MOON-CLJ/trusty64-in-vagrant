Exec {
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    logoutput => on_failure,
}

include vagrant
include apt

apt::ppa { 'ppa:pkg-vim/vim-daily': }
apt::ppa { 'ppa:jonathonf/python-3.6': }
apt::ppa { 'ppa:gophers/archive': }

class { local_repo:
    source => 'aliyun',
}

include infrastructure
include dev_tool
