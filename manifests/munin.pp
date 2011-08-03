class ntp::munin {
  case $configured_ntp_servers { '',undef: { $configured_ntp_servers = '' } }
  $ntps = regsubst(split($configured_ntp_servers, " "), "(.+)", "ntp_\\1")
  
  munin::plugin::deploy{$ntps:
    source => 'ntp/munin/ntp_',
  }
}
