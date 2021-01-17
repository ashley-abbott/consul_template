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