property :binary_source, String,
  description: 'Location on the filesystem of the extracted binary',
  name_property: true
property :destination, String,
  description: 'Location on the filesystem you would like to install the binary',
  required: true

default_action :install

action :install do
  require 'fileutils'

  if ::File.exist?("#{new_resource.destination}/#{node['consul_template']['binary_name']}")
    Chef::Log.info('consul-template binary is already installed')
  else
    Chef::Log.info("Installing consul-template binary to #{new_resource.destination}")
    FileUtils.mv(new_resource.binary_source, new_resource.destination)
  end
end

action :delete do
  require 'fileutils'

  FileUtils.rm(new_resource.binary_source)
end
