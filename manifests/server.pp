class samba::server($interfaces = '',
                    $security = '',
                    $server_string = '',
                    $unix_password_sync = '',
                    $encrypt_passwords = 'yes',
                    $passwd_program = '',
                    $passdb_backend = 'tdbsam',
                    $passwd_chat = '*new*password* %n\n*new*password* %n\n *changed*',
                    $workgroup = '',
                    $log_level = '0',
                    $syslog = '1',
                    $logon_path = '\\%N\profile\%U',
                    $logon_home = 'U:',
                    $logon_script = 'U:',
                    $bind_interfaces_only = 'yes',) {

  include samba::server::install
  include samba::server::config
  include samba::server::service

  $incl    = '/etc/samba/smb.conf'
  $context = "/files/etc/samba/smb.conf"
  $target  = "target[. = 'global']"

  augeas { 'global-section':
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => "set ${target} global",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  set_samba_option {
    'log level':            value => $log_level;
    'syslog':               value => $syslog;
    'interfaces':           value => $interfaces;
    'bind interfaces only': value => $bind_interfaces_only;
    'security':             value => $security;
    'server string':        value => $server_string;
    'unix password sync':   value => $unix_password_sync;
    'encrypt passwords':    value => $encrypt_passwords;
    'passwd program':       value => $passwd_program;
    'passdb backend':       value => $passdb_backend;
    'passwd chat':          value => $passwd_chat;
    'workgroup':            value => $workgroup;
    'logon path':           value => $logon_path;
    'logon home':           value => $logon_home;
    'logon script':         value => $logon_script;
    'dns proxy':            value => no;
  }

  file {'check_samba_user':
    # script checks to see if a samba account exists for a given user
    path    => '/sbin/check_samba_user',
    owner   => root,
    group   => root,
    mode    => "0755",
    content => template("${module_name}/check_samba_user"),
  }

  file {'add_samba_user':
    # script creates a new samba account for a given user and password
    path    => '/sbin/add_samba_user',
    owner   => root,
    group   => root,
    mode    => "0755",
    content => template("${module_name}/add_samba_user"),
  }
}

define set_samba_option ( $value = '', $signal = 'samba::server::service' ) {
  $incl    = $samba::server::incl
  $context = $samba::server::context
  $target  = $samba::server::target

  $changes = $value ? {
    default => "set \"${target}/$name\" \"$value\"",
    ''      => "rm ${target}/$name",
  }

  augeas { "samba-$name":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $changes,
    require => Augeas['global-section'],
    notify  => Class[$signal]
  }
}
