# gentoo specific things
class ntp::gentoo inherits ntp::base {
  Package['ntp']{
    category => 'net-misc',
  }
}
