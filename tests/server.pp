#"dns proxy": no

class {'samba::server':
  workgroup => 'example',
  server_string => "Example Samba Server",
  interfaces => "eth0 lo",
  security => 'share'
} {
  set_samba_option {
    'interfacesXX':           value => 'ZZZ';
    }

}


