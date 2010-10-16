# on domU's we make the clock independent
class ntp::xenu {
  case $operatingsystem {
    debian,ubuntu: {
      sysctl::value{'xen.independent_wallclock':
        value => 1,
      }
      exec{'echo "jiffies"> /sys/devices/system/clocksource/clocksource0/current_clocksource':
        unless => 'grep -q jiffies /sys/devices/system/clocksource/clocksource0/current_clocksource',
      }
    }
    default: {
      exec{'echo 1 > /proc/sys/xen/independent_wallclock':
        unless => 'grep -q 1 /proc/sys/xen/independent_wallclock',
      }
    }
  }
}
