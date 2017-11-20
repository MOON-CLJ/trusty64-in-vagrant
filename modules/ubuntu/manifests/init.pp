class ubuntu{
}

class ubuntu::apt_keys {
    ubuntu::apt_key { 'mariadb':
        key_id => '0xcbcb082a1bb943db',
    }
}
