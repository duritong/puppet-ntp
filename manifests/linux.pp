class ntp::linux inherits ntp::base {
    Service[ntpd]{
        enable => true,
    }
}
