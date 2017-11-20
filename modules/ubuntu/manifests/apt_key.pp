define ubuntu::apt_key (
  $key_id = "$title",
  $key_server = 'keyserver.ubuntu.com',
) {
  if ! $key_id {
    fail('A key_id must be provided')
  }

  exec { "Add APT key: ${key_id}":
    path => '/bin:/usr/bin:',
    command => "apt-key adv --keyserver ${key_server}  --recv-keys ${key_id}",
    unless => "apt-key list | grep -wF ${key_id}",
  }
}
