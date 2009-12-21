class ntp::base {
  include ntp::modules_dir

  package { ntp:
    ensure => installed,
    before => File["/etc/ntp.conf"],
  }

  file {"/var/lib/puppet/modules/ntp":
    ensure => directory,
    force => true,
    mode => 0755, owner => root, group => 0;
  }

  $local_stratum = $ntp_local_stratum ? {
    '' => 13,
    default => $ntp_local_stratum,
  }

  config_file { "/etc/ntp.conf":
    content => template("ntp/ntp.conf"),
    require => Package[ntp],
  }

  service{ntpd:
    ensure => running,
    subscribe => [ File["/etc/ntp.conf"], File["/etc/ntp.client.conf"], File["/etc/ntp.server.conf"] ],
  }

  if $use_munin {
    # various files and directories used by this module
    file{'/var/lib/puppet/modules/ntp/munin_plugin':
      source => "puppet://$server/modules/ntp/ntp_",
      mode => 0755, owner => root, group => 0;
    }

    $ntps = gsub(split($configured_ntp_servers, " "), "(.+)", "ntp_\\1")

    munin::plugin { $ntps:
      ensure => "munin_plugin",
      script_path_in => '/var/lib/puppet/modules/ntp'
    }
  }
  case $ntp_servers {
    '': { include ntp::client }
    default: { include ntp::server }
  }

  # collect all our configs
  Concatenated_file_part <<| tag == 'ntp' |>>
}
