define ntp::upstream_server($server_options = 'iburst') {
    ntp::add_config { "server_${name}":
      content => "server ${name} ${server_options}",
    type => "server",
  }
  # This will need the ability to collect exported defines
  # currently this is worked around by reading /etc/ntp*conf via a fact
  # case $name { $fqdn: { debug ("${fqdn}: Ignoring get_time_from for self") } default: { munin_ntp { $name: } } }
}
