require 'chef/provisioning'
require 'chef/config'

with_driver 'vagrant'

config_file = "/etc/chef/knife.rb"
Chef::Config.from_file(config_file)


with_chef_server Chef::Config[:chef_server_url], {
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]
}

machine 'mario10' do
  tag 'mariotag'
  run_list ['role[linux_base]','role[linux_tomcat]']
  converge true
end
