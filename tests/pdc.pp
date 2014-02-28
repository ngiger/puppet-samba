#"dns proxy": no
class{'samba::server':
	workgroup => workgroupTest,
	server_string => '%h',
	logon_path => '\\%L\profile\%U',
	logon_home => 'Z:',
	logon_script => 'login.bat',
	unix_password_sync => Yes,
	passwd_program => '/usr/bin/passwd %u',
	passwd_chat => '*Enter\snew\sUNIX\spassword:* %n\n *Retype\snew\sUNIX\spassword:* %n\n .',
	interfaces => "eth0 lo",
	security => 'user',
}

class{'samba::server::pdc':
  local_master               => 'Yes',
  preferred_master           => 'Yes',
  domain_master              => 'Yes',
  domain_logons              => 'Yes',
	wins_support 							 => Yes,
	panic_action               => '/usr/share/samba/panic-action %d',
	time_server => Yes,
}
