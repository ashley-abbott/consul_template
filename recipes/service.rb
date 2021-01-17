#
# Cookbook:: consul_template
# Recipe:: service
#
# Copyright:: 2021, The Authors, All Rights Reserved.

%W(#{node['consul_template']['config_dir']} #{node['consul_template']['log_dir']}).each do |dir|
  directory dir do
    mode '0755'
    action :create
  end
end

file File.join(node['consul_template']['config_dir'], 'default.json') do
  content JSON.pretty_generate(Hash[node['consul_template']['config'].map { |key, value| [key, value] }])
end

if platform?('windows')
  nssm 'consul-template' do
    program "#{node['consul_template']['install_dir']}/#{node['consul_template']['binary_name']}"
    args "-config=\"#{node['consul_template']['config_dir']}\""
    parameters node['consul_template']['nssm_params']
    action :install
  end

  service 'consul-template' do
    action :start
  end
elsif node['init_package'] == 'systemd'
  systemd_unit 'consul-template.service' do
    content(
      Unit: {
        Description: 'Consul Template Daemon',
        Wants: 'basic.target',
        After: 'basic.target network.target',
      },
      Service: {
        Environment: "#{node['consul_template']['environment_variables'].map { |key, val| %("#{key}=#{val}") }.join(' ')}",
        User: "#{node['consul_template']['service_user']}",
        Group: "#{node['consul_template']['service_group']}",
        ExecStart: "#{node['consul_template']['install_dir']}/#{node['consul_template']['binary_name']} -config #{node['consul_template']['config_dir']}",
        ExecReload: '/bin/kill -HUP $MAINPID',
        ExecStop: '/bin/kill -INT $MAINPID',
        KillMode: 'process',
        Restart: 'on-failure',
        RestartSec: '42s',
      },
      Install: {
        WantedBy: 'multi-user.target',
      }
    )
    triggers_reload true
    action [:create, :enable]
    notifies :start, 'service[consul-template]', :delayed
  end

  service 'consul-template' do
    supports status: true, restart: true, reload: true
    action :nothing
  end
else
  init service
end
