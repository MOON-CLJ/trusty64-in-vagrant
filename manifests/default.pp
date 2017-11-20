Exec {
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    logoutput => on_failure,
}

include vagrant
include ubuntu::apt_keys

class { local_repo:
    source => 'aliyun',
}

include infrastructure
include dev_tool
