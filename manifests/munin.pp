# configure monitoring of the confiured ntp servers
class ntp::munin {
  munin::plugin{
    'ntp_offset':
  }
}
