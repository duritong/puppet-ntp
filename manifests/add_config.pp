define ntp::add_config($content, $type) {
  include ntp::modules_dir
  config_file { "/var/lib/puppet/modules/ntp/ntp.${type}.d/${name}":
    content => "$content\n",
    before => File["/etc/ntp.${type}.conf"],
  }
}
