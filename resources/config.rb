property :templates, kind_of: Array,
  description: 'Templates for service to monitor',
  default: []
property :name, kind_of: String,
  description: 'name of the template to place',
  name_property: true

default_action :create

action :create do
  templates = new_resource.templates

  template ::File.join(node['consul_template']['config_dir'], new_resource.name) do
    cookbook 'consul_template'
    source 'config-template.hcl.erb'
    #unless platform?('windows')
    #user consul_template_user
    #group consul_template_group
    #mode node['consul_template']['template_mode']
    #end
    variables(
      templates: templates
    )
    not_if { templates.empty? }
  end
end

action :delete do
end