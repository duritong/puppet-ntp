class ntp::gentoo inherits ntp::linux {
    Package[ntp]{
        category => 'net-misc',
    }
}
