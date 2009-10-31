# This fact returns the set of configured NTP servers
# from the managed config files.
Facter.add("configured_ntp_servers") do
  setcode do
    Dir.glob("/etc/ntp*.conf").collect do |name|
      File.new(name).readlines.collect do |line|
        if match = line[/^(server|peer) ([^ ]+)/, 2]
          match.chomp
        end
      end
    end.flatten.compact.uniq.sort.join(" ")
  end
end
