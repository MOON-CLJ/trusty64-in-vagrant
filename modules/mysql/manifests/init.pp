class mysql {
    include mysql::mariadb10
    $mysql_server_pkg = 'mariadb-server-10.0'
    $mysql_client_pkg = 'mariadb-client-10.0'

    service { 'mysql':
        ensure     => true,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => [
            Package[$mysql_server_pkg],
            File['mysql custom config'],
        ],
    }

    file { 'mysql custom config':
        ensure  => present,
        path    => '/etc/mysql/conf.d/shire.cnf',
        source  => 'puppet:///modules/mysql/dev.cnf',
        require => Package[$mysql_server_pkg],
    }

    $user_cmd = "grant all privileges on *.* to 'eye'@'%' identified by 'sauron' with grant option;"
    exec { 'create mysql user':
        command   => "/usr/bin/mysql -uroot -e\"${user_cmd}\"",
        unless    => '/usr/bin/mysqladmin -ueye -psauron -h127.0.0.1 status',
        subscribe => [
          Package[$mysql_server_pkg],
          Package[$mysql_client_pkg],
          Service['mysql'],
        ],
    }

}

class mysql::mariadb10 {
    package { 'mysql-common':
        ensure => '10.0.33+maria-1~trusty',
    } ->
    package { 'libmysqlclient18':
        ensure => '10.0.33+maria-1~trusty',
    } ->
    package { 'libmariadbclient-dev':
        ensure => '10.0.33+maria-1~trusty',
    } ->
    package { 'mariadb-server-10.0':
        ensure => '10.0.33+maria-1~trusty',
    } ->
    package { 'mariadb-client-10.0':
        ensure => '10.0.33+maria-1~trusty',
    }
}

class mysql::mariadb10::disable {
    package {[
        'maria-common',
        'mariadb-server-10.0',
        'mariadb-client-10.0',
        'mariadb-client-core-10.0',
        'mariadb-server-core-10.0',
        ]:
            ensure => absent,
    }
}
