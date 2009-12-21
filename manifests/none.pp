# include this class on hosts who collect files but do not have other ntp infrastructure
class ntp::none {
  include ntp::modules_dir
  exec {
    "concat_/var/lib/puppet/modules/ntp/ntp.client.d":
      command => "true",
      refreshonly => true;
    "concat_/var/lib/puppet/modules/ntp/ntp.server.d":
      command => "true",
      refreshonly => true,
  }
  # also provide dummy directories!
  modules_dir { ["ntp/ntp.server.d", "ntp/ntp.client.d"]: }
}
