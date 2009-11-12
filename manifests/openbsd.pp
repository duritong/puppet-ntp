class ntp::openbsd inherits ntp::base {
    Service[ntpd]{
        restart => "kill -HUP `ps ax | grep -v grep | grep ntpd | head -n 1 | awk '{ print \$1 }'`",
        stop => "kill `ps ax | grep -v grep | grep ntpd | head -n 1 | awk '{ print \$1 }'`",
        start => '/usr/sbin/ntpd',
        hasstatus => false,
    }
}
