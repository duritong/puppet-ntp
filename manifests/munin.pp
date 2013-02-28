# configure monitoring of the confiured ntp servers
class ntp::munin {
  $ntps = regsubst(reject(split($::configured_ntp_servers, ' '), '127\.127\.1\.0'),'(.+)', "ntp_\\1")

  munin::plugin::deploy{$ntps:
    source  => 'ntp/munin/ntp_',
    seltype => 'munin_services_plugin_exec_t',
  }
}
