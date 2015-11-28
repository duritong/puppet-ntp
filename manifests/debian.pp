# debian specific things
class ntp::debian inherits ntp::base {
  case $::lsbdistcodename {
    'sarge': {
      Package[ntp]{
        name => 'ntp-server',
      }
    }
    default: {}
  }
  Service['ntpd']{
    name => 'ntp',
  }
}
