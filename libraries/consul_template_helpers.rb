class ConsulTemplate
  def initialize(node)
    @node = node
  end

  def archive
    str = ['consul-template', @node['consul_template']['version'], @node['os'], arch(@node['kernel']['machine'])].join('_')
    str + @node['consul_template']['archive_ext']
  end

  def arch(machine)
    if machine =~ /x86_64/
      'amd64'
    else
      '386'
    end
  end

  def checksum
    require 'open-uri'

    sha256sums = "consul-template_#{@node['consul_template']['version']}_SHA256SUMS"
    source_url = @node['consul_template']['source_url']
    version = @node['consul_template']['version']
    checksum = nil

    URI.open("#{source_url}/#{version}/#{sha256sums}") do |f|
      f.each_line do |line|
        checksum = line.split(' ')[0].chomp if line.match(/^.* #{archive}$/)
      end
    end

    # Chef::Log.info("The checksum for version #{node['consul_template']['version']} is: #{checksum.to_s}")
    checksum.to_s
  end
end

class Chef
  class Resource
    def consul_template
      ConsulTemplate.new(node)
    end
  end

  class Recipe
    def consul_template
      ConsulTemplate.new(node)
    end
  end
end
