require 'spec_helper'

describe 'consul_template_config' do
  step_into :consul_template_config

  context 'What all attributes are default, Centos 7.4' do
    platform 'centos', '7.4'

    recipe do
      consul_template_config 'test.hcl' do
        templates [
          {
            source: '/path/to/first/source',
            destination: '/path/to/first/dest',
          },
        ]
      end

      it { is_expected.to create_template('/etc/consul-template.d/test.hcl') }
    end
  end

  context 'When all attributes are default, Ubuntu' do
    platform 'ubuntu'

    recipe do
      consul_template_config 'test.hcl' do
        templates [
          {
            source: '/path/to/first/source',
            destination: '/path/to/first/dest',
          },
        ]
      end

      it { is_expected.to create_template('/etc/consul-template.d/test.hcl') }
    end
  end
end
