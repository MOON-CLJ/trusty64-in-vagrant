Exec {
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    logoutput => on_failure,
}

include vagrant
include apt

apt::ppa { 'ppa:pkg-vim/vim-daily': }

class { local_repo:
    source => 'aliyun',
}

include infrastructure
include dev_tool
