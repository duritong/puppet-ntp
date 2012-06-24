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

  if $ntp::servers {
    class{'ntp::client':
      manage_shorewall => $ntp::manage_shorewall,
    }
  } else {
    class{'ntp::server':
      upstream_servers => $ntp::servers,
      manage_nagios => $ntp::manage_nagios,
    }
  }
}
