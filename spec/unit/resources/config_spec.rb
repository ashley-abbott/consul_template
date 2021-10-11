require 'spec_helper'

describe 'aa_consul_template_config' do
  default_attributes['consul_template']['config_dir'] = '/etc/consul-template.d'
  step_into :aa_consul_template_config

  context 'When action is :create, Centos 7' do
    platform 'centos', '7'

    recipe do
      aa_consul_template_config 'test.hcl' do
        templates [
          {
            source: '/path/to/first/source',
            destination: '/path/to/first/dest',
          },
        ]
      end
    end

    it { is_expected.to create_template('/etc/consul-template.d/test.hcl') }
  end

  context 'When action is :create and templates.empty?, Centos 7' do
    platform 'centos', '7'

    recipe do
      aa_consul_template_config 'test.hcl'
    end

    it { is_expected.to_not create_template('/etc/consul-template.d/test.hcl') }
  end

  context 'When action is :delete, Centos 7' do
    platform 'centos', '7'

    recipe do
      aa_consul_template_config 'test.hcl' do
        templates []
        action :delete
      end
    end

    it { is_expected.to delete_template('/etc/consul-template.d/test.hcl') }
  end

  context 'When action is :create, Ubuntu' do
    platform 'ubuntu'

    recipe do
      aa_consul_template_config 'test.hcl' do
        templates [
          {
            source: '/path/to/first/source',
            destination: '/path/to/first/dest',
          },
        ]
      end
    end

    it { is_expected.to create_template('/etc/consul-template.d/test.hcl') }
  end

  context 'When action is :create and templates.empty?, Ubuntu' do
    platform 'ubuntu'

    recipe do
      aa_consul_template_config 'test.hcl'
    end

    it { is_expected.to_not create_template('/etc/consul-template.d/test.hcl') }
  end

  context 'When action is :delete, Ubuntu' do
    platform 'ubuntu'

    recipe do
      aa_consul_template_config 'test.hcl' do
        templates []
        action :delete
      end
    end

    it { is_expected.to delete_template('/etc/consul-template.d/test.hcl') }
  end
end
