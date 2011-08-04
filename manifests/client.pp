class ntp::client {
  concat{'/etc/ntp.client.conf':
    notify => Service['ntpd'],
  }
  # collect all our configs
  Concat::Fragment <<| tag == 'ntp' |>>

  file{'/etc/ntp.server.conf':
    content => "\n",
    owner => root, group => 0, mode => 0644;
  }

  if $use_shorewall {
    include shorewall::rules::ntp::client
  }
}
