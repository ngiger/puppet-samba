# This module act as  PDC Primary Domain Controller
#
# Copyright (c) 2014 Niklaus Giger niklaus.giger@member.fsf.org
# Licensed under the MIT License, http://opensource.org/licenses/MIT

class samba::server::pdc($ensure = present,
  $preferred_master           = 'Yes',
  $local_master               = 'Yes',
  $domain_logons              = 'Yes',
  $domain_master              = 'Yes',
  $logon_home                 = 'H:',
  $wins_support               = 'Yes',
  $time_server                = 'Yes',
  $panic_action               = '') {

  include samba::server::config
  set_samba_option {
    'preferred master':       value => $preferred_master;
    'domain logons':          value => $domain_logons;
    'domain master':          value => $domain_master;
    'local master':           value => $local_master;
    'wins support':           value => $wins_support;
    'time server':            value => $time_server;
    'panic action':           value => $panic_action;
  }
}
