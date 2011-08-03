# on domU's we make the clock independent
class ntp::xenu {
  exec{'echo 1 > /proc/sys/xen/independent_wallclock':
    unless => 'grep -q 1 /proc/sys/xen/independent_wallclock',
    onlyif => 'test -f /proc/sys/xen/independent_wallclock',
  }
}
