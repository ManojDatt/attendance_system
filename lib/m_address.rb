# encoding: utf-8

require 'rubygems' unless defined?(::Gem)
require 'systemu'

module MAddress
  class << self

    def mac
      return @mac_address if defined? @mac_address and @mac_address
      re = %r/[^:\-](?:[0-9A-F][0-9A-F][:\-]){5}[0-9A-F][0-9A-F][^:\-]/io
      cmds = '/sbin/ifconfig', '/bin/ifconfig', 'ifconfig', 'ipconfig /all', 'cat /sys/class/net/*/address'

      null = test(?e, '/dev/null') ? '/dev/null' : 'NUL'

      output = nil
      cmds.each do |cmd|
        status, stdout, stderr = systemu(cmd) rescue next
        next unless stdout and stdout.size > 0
        output = stdout and break
      end
      raise "all of #{ cmds.join ' ' } failed" unless output
      print output  
      @mac_address = parse(output)
    end

    def parse(output)
      lines = output.split(/\n/)

      candidates = lines.select{|line| line =~ RE}
      print candidates
#       raise 'no mac address candidates' unless candidates.first
#       candidates.map!{|c| c[RE].strip}

#       maddr = candidates.first
#       raise 'no mac address found' unless maddr

#       maddr.strip!
#       maddr.instance_eval{ @list = candidates; def list() @list end }
#       maddr
    end

  end

  RE = %r/(?:[^:\-]|\A)(?:[0-9A-F][0-9A-F][:\-]){5}[0-9A-F][0-9A-F](?:[^:\-]|\Z)/io
end

