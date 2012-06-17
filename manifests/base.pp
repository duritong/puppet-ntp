class ntp::base {
  package {'ntp':
    ensure => installed,
  }


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

  case $ntp::servers {
    '': {
      class{'ntp::client':
        manage_shorewall => $ntp::manage_shorewall,
      }
    }
    default: {
      class{'ntp::server':
        upstream_servers => $ntp::servers,
        manage_nagios => $ntp::manage_nagios,
      }
    }
  }
}
