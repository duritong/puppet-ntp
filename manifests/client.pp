class ntp::client {
  concat{'/etc/ntp.client.conf':
    notify => Service['ntpd'],
  }
  # collect all our configs
  Concat::Fragment <<| tag == 'ntp-client' |>>

  file{'/etc/ntp.server.conf':
    content => "\n",
    owner => root, group => 0, mode => 0644;
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::ntp::client
  }
}
