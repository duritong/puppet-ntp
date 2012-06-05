class ntp::debian inherits ntp::base {
  case $::lsbdistcodename {
    'sarge': {
      Package[ntp]{
        name => 'ntp-server',
      }
    }
  }
  Service['ntpd']{
    name => 'ntp',
  }
}
