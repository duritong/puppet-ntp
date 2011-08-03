class ntp::base {
  package {'ntp':
    ensure => installed,
  }

  $local_stratum = hiera('ntp_local_stratum',13)

  file { "/etc/ntp.conf":
    content => template("ntp/ntp.conf"),
    require => Package['ntp'],
    notify => Service['ntpd'],
    owner => root, group => 0, mode => 0644;
  }

  service{'ntpd':
    enable => true,
    ensure => running,
  }

  $ntp_servers = hiera('ntp_servers','')
  case $ntp_servers {
    '': { include ntp::client }
    default: {
      class{'ntp::server':
        upstream_servers => $ntp_servers,
      }
    }
  }

  # collect all our configs
  Concat::Fragment <<| tag == 'ntp' |>>
}
