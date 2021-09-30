default['consul_template']['source_url'] = 'https://releases.hashicorp.com/consul-template'
default['consul_template']['version'] = '0.25.1'
default['consul_template']['archive_ext'] = '.zip'
default['consul_template']['install_dir'] = if platform?('windows')
                                              ENV['SystemDrive'] + '\Program Files\consul_template'
                                            else
                                              '/usr/local/bin'
                                            end
default['consul_template']['binary_name'] = if platform?('windows')
                                              'consul-template.exe'
                                            else
                                              'consul-template'
                                            end
default['consul_template']['config'] = {}
default['consul_template']['config']['consul'] = {}
default['consul_template']['config']['consul']['address'] = '127.0.0.1:8500'
default['consul_template']['config']['vault']['address'] = 'http://120.0.0.1:8200'
default['consul_template']['config_dir'] = if platform?('windows')
                                             ENV['SystemDrive'] + '\Program Files\consul_template\consul_template.d'
                                           else
                                             '/etc/consul-template.d'
                                           end
default['consul_template']['log_dir'] = if platform?('windows')
                                          ENV['SystemDrive'] + '\Program Files\consul_template\logs'
                                        else
                                          '/var/log/consul-template'
                                        end
default['consul_template']['environment_variables'] = {}
default['consul_template']['consul_addr'] = '127.0.0.1:8500'
default['consul_template']['vault_addr'] = 'https://127.0.0.1:8200'
default['consul_template']['manage_service'] = false

# Windows only
if platform?('windows')
  default['consul_template']['nssm_params'] = {
    'AppDirectory'     => "#{node['consul_template']['install_dir']}",
    'AppStdout'        => "#{node['consul_template']['install_dir']}/stdout.log",
    'AppStderr'        => "#{node['consul_template']['install_dir']}/error.log",
    'AppRotateFiles'   => 1,
    'AppRotateOnline'  => 1,
    'AppRotateBytes'   => 20_000_000,
  }
end
