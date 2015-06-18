#
# chef-provisioning recipe to create AWS EC2 instances behind an HTTP ELB
# Required attributes are stored in ./attrs.json
# In the json file, set node['provision']['all'] to "true" to 
# create the environment and "false" to destroy it
#

require 'chef/provisioning/aws_driver'

# Specify the driver to be used here
with_driver 'aws'

# Enable Chef server communication
config_file = "/etc/chef/knife.rb"
Chef::Config.from_file(config_file)
with_chef_server Chef::Config[:chef_server_url], {
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]
}

log "*** Creating chef environment: #{node['provision']['name_prefix']}"

# Create/Destroy the Chef environment for the nodes
chef_environment node['provision']['name_prefix'] do
  default_attributes node['provision']['default_attributes']
  description "Auto-generated using chef-provisioning"
  complete true
  action (node['provision']['all']=="true" ? :create : :delete)
end

# Create an array of machine names
the_machines = []
for i in (1..node['provision']['instances'].to_i)
  the_machines.push("#{node['provision']['name_prefix']}-#{i}")
end

# Create/Destroy machines in parallel
machine_batch do
  the_machines.each do |machine_name|
    machine machine_name do
      tag "name=#{machine_name}"
      run_list node['provision']['chef']['run_list'].split(/\s*,\s*/)
      chef_environment node['provision']['name_prefix']
      converge true
      machine_options({
        :ssh_username => 'root',
        :bootstrap_options => {
          :key_name => node['provision']['cloud']['key_name'],
          :availability_zone => node['provision']['cloud']['availability_zone'],
          :instance_type => node['provision']['cloud']['instance_type'],
          :image_id => node['provision']['cloud']['image_id']
        }
      })
    end
  end
  action (node['provision']['all']=="true" ? :converge : :destroy)
end

# Create/Destroy an AWS ELB used as an HTTP load balancer for the machines
load_balancer "#{node['provision']['name_prefix']}-elb" do
  load_balancer_options :availability_zones => [node['provision']['cloud']['availability_zone']],
    :listeners => [{
      :port => 80,
      :protocol => :http,
      :instance_port => 80,
      :instance_protocol => :http,
    }]
  machines the_machines
  action (node['provision']['all']=="true" ? :create : :destroy)
end
