[![Coverage Status](https://coveralls.io/repos/github/ashley-abbott/consul_template/badge.svg?branch=main)](https://coveralls.io/github/ashley-abbott/consul_template?branch=main)

# consul_template

 Installs and configures [consul-template](https://github.com/hashicorp/consul-template)

## Supported Platforms

- Ubuntu 18.04
- Centos 7
- Windows

## Attributes

- `default['consul_template']['source_url']` - Source for the consul-template binary
  - (default: `https://releases.hashicorp.com/consul-template`)
- `default['consul_template']['version']` - Version of consul-template to install
  - (default: `0.25.1`)
- `default['consul_template']['archive_ext']` - File extension of the downloaded binary
  - (default: `.zip`)
- `default['consul_template']['install_dir']` - Location on the filesystem to install the binary
  - default:
    - Windows: `ENV['SystemDrive'] + '\Program Files\consul_template`
    - Linux: `/usr/local/bin`
- `default['consul_template']['binary_name']` - Name of the binary file once extracted
  - default:
    - Windows: `consul-template.exe`
    - Linux: `consul-template`
- `default['consul_template']['config']['consul']['address']` - Address to access Consul server
  - (default: `127.0.0.1:8500`)
- `default['consul_template']['config']['vault']['address']` - Address to access Consul Vault
  - (default: `http://127.0.0.1:8200`)
- `default['consul_template']['config_dir']` - Location on the filesystem to place configuration files
  - default:
    - Windows: `ENV['SystemDrive'] + '\Program Files\consul_template\consul_template.d`
    - Linux: `/etc/consul-template.d`
- `default['consul_template']['log_dir']` - Logging directory
  - default:
    - Windows: `ENV['SystemDrive'] + '\Program Files\consul_template\logs`
    - Linux: `/var/log/consul-template`
- `default['consul_template']['environment_variables']` - Linux Only: Additional environment variables to pass to systemd unit file
- `default['consul_template']['manage_service']` - Bool: Whether or not to create and manage a service for consul-template
  - (default: `false`)

## Resources

`consul_template_config` - Used to place HCL files for the consul-template service to action. It accepts two properties, `name` and `templates`.

- `name` - type: string (default: `name of resource`)
- `templates` - type: array (accepts one or more ruby hashes)

*Example:*

```ruby
consul_template_config 'test.hcl' do
  templates [
    {
      source: '/path/to/first/source',
      destination: '/path/to/first/dest',
      backup: true,
      perms: '0644',
      wait: {
        min: '2s',
        max: '5s',
      },
    },
    {
      source: '/path/to/second/source',
      destination: '/path/to/second/dest',
      backup: false,
      perms: '0755',
      wait: {
        min: '10s',
        max: '15s',
      },
    },
  ]
end
```

This will yield a file that looks like:

```text
template {
  source = "/path/to/first/source" 
  destination = "/path/to/first/dest" 
  backup = true 
  perms = 0644 
  wait {
    min = "2s"
    max = "5s"
  } 
}

template {
  source = "/path/to/second/source" 
  destination = "/path/to/second/dest" 
  backup = false 
  perms = 0755 
  wait {
    min = "10s"
    max = "15s"
  } 
}
```
