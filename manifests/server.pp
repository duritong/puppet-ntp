# this is a server, connect to the specified upstreams
class ntp::server($upstream_servers) {
  ntp::upstream_server {$ntp::servers::upstream_servers : }

  # export this server for our own clients
  @@concat::fragment{
    "server_${fqdn}":
      target  => '/etc/ntp.client.conf',
      content => "server ${fqdn} iburst\n",
      tag => 'ntp';
    # export this server for our other servers
    "peer_${fqdn}":
      target  => '/etc/ntp.server.conf',
      content => "peer ${fqdn} iburst\nrestrict ${fqdn} nomodify notrap\n",
      tag => 'ntp';
  }
  concat{'/etc/ntp.server.conf':
    notify => Service['ntpd'],
  }
  file{'/etc/ntp.client.conf':
    content => "\n",
    owner => root, group => 0, mode => 0644;
  }

  if hiera('use_nagios',false) {
    include nagios::service::ntp
  }

  if hiera('use_shorewall',false) {
    include shorewall::rules::ntp::client
    include shorewall::rules::ntp::server
  }
}

