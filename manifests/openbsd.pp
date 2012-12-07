# minimal config mgmt for openbsd
class ntp::openbsd {
  file_line{
    'enable_ntpd':
      path => '/etc/rc.conf.local',
      line => 'ntpd_flags=',
  }
  service{'ntpd':
    restart   => "kill -HUP `ps ax | grep -v grep | grep ntpd | head -n 1 | awk '{ print \$1 }'`",
    stop      => "kill `ps ax | grep -v grep | grep ntpd | head -n 1 | awk '{ print \$1 }'`",
    start     => '/usr/sbin/ntpd',
    hasstatus => false,
    enable    => undef,
  }

  ntp::openbsd::server{
    $ntp::servers:;
  }
}
