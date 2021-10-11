#
# Cookbook:: aa_consul_template
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

remote_file 'consul-template' do
  path "#{Chef::Config['file_cache_path']}/#{consul_template.archive}"
  source "#{node['consul_template']['source_url']}/#{node['consul_template']['version']}/#{consul_template.archive}"
  checksum consul_template.checksum
  action :create_if_missing
end

archive_file 'consul-template' do
  path "#{Chef::Config['file_cache_path']}/#{consul_template.archive}"
  destination node['consul_template']['install_dir']
  overwrite true unless platform?('windows')
  action :extract
end

include_recipe 'aa_consul_template::service' if node['consul_template']['manage_service']
