class {'samba::server':
	workgroup => 'example',
	server_string => "Example Samba Server",
	interfaces => "eth0 lo",
	security => 'ads'
}

samba::server::share {'ri-storage':
	comment           => 'RBTH User Storage',
	path              => "$smb_share",
	browsable         => true,
	writable          => true,
	create_mask       => 0770,
	directory_mask    => 0770,
}

class { 'samba::server::ads':
		winbind_acct    => $::domain_admin,
		winbind_pass    => $::admin_password,
		realm           => 'EXAMPLE.COM',
		nsswitch        => true,
		target_ou       => "Nix_Mashine"
}
