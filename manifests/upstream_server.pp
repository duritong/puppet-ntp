define ntp::upstream_server($server_options = 'iburst') {
  concat::fragment{"server_${name}":
    target => "/etc/ntp.server.conf",
    content => "server ${name} ${server_options}\n",
  }
}
