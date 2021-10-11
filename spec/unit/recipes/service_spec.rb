#
# Cookbook:: aa_consul_template
# Spec:: service
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aa_consul_template::service' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04').converge(described_recipe) }
    let(:service) { chef_run.service('consul-template.') }
    let(:systemd_unit) { chef_run.systemd_unit('consul-template.service') }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it { is_expected.to create_systemd_unit('consul-template.service') }
    it { is_expected.to enable_systemd_unit('consul-template.service') }
    it { expect(systemd_unit).to notify('service[consul-template]').to(:start).delayed }
  end

  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7').converge(described_recipe) }
    let(:service) { chef_run.service('consul-template.') }
    let(:systemd_unit) { chef_run.systemd_unit('consul-template.service') }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it { is_expected.to create_systemd_unit('consul-template.service') }
    it { is_expected.to enable_systemd_unit('consul-template.service') }
    it { expect(systemd_unit).to notify('service[consul-template]').to(:start).delayed }
  end
end
