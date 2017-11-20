define ubuntu::ppa_repo (
  $ensure = present,
  $key = false,
  $release = "trusty",
) {
  $filename = regsubst($title, "/", "-", "G")
  $full_file_path = "/etc/apt/sources.list.d/ppa-${filename}.list"

  if $ensure == present {
    if ! $key {
      fail('A key must be provided')
    }

    if ! defined(Ubuntu::Apt_key[$key]) {
      ubuntu::apt_key { $key: }
    }
    file { $full_file_path:
      content => template("ubuntu/ppa-source.list.erb"),
    }
  } elsif $ensure == absent {
    file { $full_file_path:
      ensure => absent,
    }
  } else {
    fail('$ensure must be trusty or absent')
  }
}
