require_relative '../../../libraries/consul_template_helpers'

# InSpec test for recipe consul_template::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  describe file("#{Chef::Config['file_cache_path']}/#{consul_template.archive}") do
    it { should exist }
    its('sha256') { should eq consul_template.checksum }
  end
end
