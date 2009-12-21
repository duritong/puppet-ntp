# this is a server, connect to the specified upstreams
class ntp::server {
  include ntp::modules_dir
  info ( "${fqdn} will act as ntp server using ${ntp_servers} as upstream" )
  ntp::upstream_server { $ntp_servers: }
    # export this server for our own clients
  @@concatenated_file_part {
    "server_${fqdn}":
      dir => "/var/lib/puppet/modules/ntp/ntp.client.d",
      content => "server ${fqdn} iburst\n",
      tag => 'ntp',
      ## TODO: activate this dependency when the bug is fixed
      #before => File["/etc/ntp.client.conf"]
      ;
    # export this server for our other servers
    "peer_${fqdn}":
      dir => "/var/lib/puppet/modules/ntp/ntp.server.d",
      content => "peer ${fqdn} iburst\nrestrict ${fqdn} nomodify notrap\n",
      tag => 'ntp',
      ## TODO: activate this dependency when the bug is fixed
      #before => File["/etc/ntp.server.conf"]
      ;
  }
  concatenated_file {"/etc/ntp.server.conf":
    dir => "/var/lib/puppet/modules/ntp/ntp.server.d",
  }
  file { "/var/lib/puppet/modules/ntp/ntp.client.d": ensure => directory, }
  # provide dummy dependency for collected files
  exec { "concat_/var/lib/puppet/modules/ntp/ntp.client.d":
    command => "true",
    refreshonly => true,
  }
  config_file { "/etc/ntp.client.conf": content => "\n", }

  if $use_nagios {
    include nagios::service::ntp
  }

  if $use_shorewall {
    include shorewall::rules::ntp::client
    include shorewall::rules::ntp::server
  }
}

