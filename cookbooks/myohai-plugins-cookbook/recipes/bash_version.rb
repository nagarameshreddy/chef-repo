# Install plugin to detect bash version and shellshock vulnerability

ohai 'reload_bash_version' do
  plugin 'bash'
  action :nothing
end

cookbook_file "#{node['ohai']['plugin_path']}/bash_version.rb" do
  source 'plugins/bash_version.rb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :reload, 'ohai[reload_bash_version]', :immediately
end

include_recipe 'ohai::default'
