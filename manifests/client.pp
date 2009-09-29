class ntp::client {
    info ( "${fqdn} will act as ntp client" )
    # collect all our servers
    concatenated_file { "/etc/ntp.client.conf":
        dir => "/var/lib/puppet/modules/ntp/ntp.client.d",
    }

    # unused configs
    file { "/var/lib/puppet/modules/ntp/ntp.server.d": ensure => directory, }
    # provide dummy dependency for collected files
    exec { "concat_/var/lib/puppet/modules/ntp/ntp.server.d":
        command => "true",
        refreshonly => true,
    }
    config_file { "/etc/ntp.server.conf": content => "\n", }

    if $use_shorewall {
      include shorewall::rules::ntp::client
    }
}
