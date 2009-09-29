class ntp::debian inherits ntp::linux {
    case $lsbdistcodename {
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
