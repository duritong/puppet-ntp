# configure a server for openbsd
define ntp::openbsd::server(){
  file_line{
    "ntp_server_${name}":
      line   => "server ${name}",
      path   => '/etc/ntpd.conf',
      notify => Service['ntpd'],
  }
}
