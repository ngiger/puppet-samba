define samba::server::share($ensure = present,
                            $browsable = '',
                            $comment = '',
                            $create_mask = '',
                            $directory_mask = '',
                            $force_create_mode = '',
                            $force_directory_mode = '',
                            $force_group = '',
                            $force_user = '',
                            $guest_ok = '',
                            $guest_only = '',
                            $path = '',
                            $oplocks = '',
                            $level2_oplocks = '',
                            $veto_oplock_files = '',
                            $read_only = '',
                            $public = '',
                            $write_list = '',
                            $printable = '',
                            $valid_users = '',
                            $profile_acl = '',
                            ) {
                              
  $incl    = $samba::server::incl
  $context = $samba::server::context
  $target  = "target[. = '${name}']"

  augeas { "${name}-section":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm  ${target} '${name}'",
    },
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  if $ensure == 'present' {
    $changes = [
      $browsable ? {
          true    => "set \"${target}/browsable\" yes",
          false   => "set \"${target}/browsable\" no",
          default => "rm  \"${target}/browsable\"",
      },
      $comment ? {
          default => "set \"${target}/comment\" '${comment}'",
          ''      => "rm  \"${target}/comment\"",
      },
      $create_mask ? {
        default => "set \"${target}/create mask\" '${create_mask}'",
        ''      => "rm  \"${target}/create mask\"",
      },
      $directory_mask ? {
        default => "set \"${target}/directory mask\" '${directory_mask}'",
        ''      => "rm  \"${target}/directory mask\"",
      },
      $force_create_mode ? {
        default => "set \"${target}/force create mode\" '${force_create_mode}'",
        ''      => "rm  \"${target}/force create mode\"",
      },
      $force_directory_mode ? {
        default => "set \"${target}/force directory mode\" '${$force_directory_mode}'",
        ''      => "rm  \"${target}/force directory mode\"",
      },
      $force_group ? {
        default => "set \"${target}/force group\" '${force_group}'",
        ''      => "rm  \"${target}/force group\"",
      },
      $force_user ? {
        default => "set \"${target}/force user\" '${force_user}'",
        ''      => "rm  \"${target}/force user\"",
      },
      $guest_ok ? {
        true    => "set \"${target}/guest ok\" yes",
        false   => "set \"${target}/guest ok\" no",
        default => "rm  \"${target}/guest ok\"",
      },
      $guest_only ? {
        true    => "set \"${target}/guest only\" yes",
        false   => "set \"${target}/guest only\" no",
        default => "rm  \"${target}/guest only\"",
      },
      $path ? {
        default => "set ${target}/path '${path}'",
        ''      => "rm  ${target}/path",
      },
       # http://www.samba.org/samba/docs/man/manpages-3/smb.conf.5.html#READONLY 
      $read_only ? {
        true => "set \"${target}/read only\" yes",
        false => "set \"${target}/read only\" no",
        default => "rm \"${target}/read only\"",
      },
      $public ? {
        true    => "set \"${target}/public\" yes",
        false   => "set \"${target}/public\" no",
        default => "rm  \"${target}/public\"",
      },
      $printable ? {
        true    => "set \"${target}/printable\" yes",
        false   => "set \"${target}/printable\" no",
        default => "rm  \"${target}/printable\"",
      },
    ]

    augeas { "${name}-changes":
      incl    => $incl,
      lens    => 'Samba.lns',
      context => $context,
      changes => $changes,
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-profile_acls":
      context => $context,
      changes => $profile_acls ? {
        default => "set \"${target}/profile acls\" '${profile_acls}'",
        ''      => "rm \"${target}/profile acls\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
    
    augeas { "${name}-valid_users":
      context => $context,
      changes => $valid_users ? {
        default => "set \"${target}/valid users\" '${valid_users}'",
        ''      => "rm \"${target}/valid users\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-oplocks":
      context => $context,
      changes => $oplocks ? {
        default => "set \"${target}/oplocks\" '${oplocks}'",
        ''      => "rm \"${target}/oplocks\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
    augeas { "${name}-level2_oplocks":
      context => $context,
      changes => $level2_oplocks ? {
        default => "set \"${target}/level2 oplocks\" '${level2_oplocks}'",
        ''      => "rm \"${target}/level2 oplocks\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
    augeas { "${name}-veto_oplock_files":
      context => $context,
      changes => $veto_oplock_files ? {
        default => "set \"${target}/veto oplock files\" '${veto_oplock_files}'",
        ''      => "rm \"${target}/veto oplock files\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
    augeas { "${name}-write_list":
      context => $context,
      changes => $write_list ? {
        default => "set \"${target}/write list\" '${write_list}'",
        ''      => "rm \"${target}/write list\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

  }
}
