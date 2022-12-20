# InSpec test for recipe consul_template::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end

  describe file("#{Chef::Config['file_cache_path']}/#{consul_template.archive}") do
    it { should exist }
    its('sha256') { should eq consul_template.checksum }
  end
end
