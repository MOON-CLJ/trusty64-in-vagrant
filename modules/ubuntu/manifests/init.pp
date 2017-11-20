class ubuntu{
}

class ubuntu::apt_keys {
    ubuntu::apt_key { '0xcbcb082a1bb943db':
        key_server => 'hkp://keyserver.ubuntu.com:80'
    }
    ubuntu::apt_key { '6F6B15509CF8E59E6E469F327F438280EF8D349F':
        key_server => 'hkp://pgp.mit.edu:80'
    }
}
