#
# Cookbook:: aa_consul_template
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aa_consul_template::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it { is_expected.to create_remote_file_if_missing("#{Chef::Config['file_cache_path']}/consul-template_0.25.1_linux_amd64.zip") }
  end

  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it { is_expected.to create_remote_file_if_missing("#{Chef::Config['file_cache_path']}/consul-template_0.25.1_linux_amd64.zip") }
  end
end
