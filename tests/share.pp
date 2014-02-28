#"dns proxy": no
include samba
include samba::server::config

samba::server::share {'pdf-ausgabe':
	comment => 'Ausgabe für Drucken in Datei via PDF',
	path => "/usr",
	browsable => true,
	read_only => true,
	force_user => '%S',
	guest_only => false,
	guest_ok => false,
	create_mask => 0600,
	directory_mask => 0700,
}

samba::server::share {'share_with_defaults':
			path => '/opt',
}
samba::server::share {'share_false':
			browsable => false,
			comment => 'Kommentar',
			create_mask => 0177,
			directory_mask => 0277,
			force_create_mode => 010,
			force_directory_mode => 020,
			path => '/opt',
      public => false,
      guest_ok => false,
      writable => false,
      printable => false,
      write_list => '@admin',
      valid_users => '@admin2',
      force_user => 'backup',
      force_group => 'root',
      oplocks => false,
      veto_oplock_files => "*oplocked;*mdx",
      level2_oplocks => "*level2_oplocks",
    }
samba::server::share {'share_true':
			browsable => true,
			comment => 'Kommentarx',
			create_mask => 01777,
			directory_mask => 02777,
			force_create_mode => 0100,
			force_directory_mode => 0200,
			path => '/opt',
      public => true,
      guest_ok => true,
      writable => true,
      printable => true,
      write_list => '@admin',
      valid_users => '@admin2',
      force_user => 'backup',
      force_group => 'root',
      oplocks => true,
      veto_oplock_files => "*oplocked;*exe",
      level2_oplocks => "*level2_oplocks",
    }
