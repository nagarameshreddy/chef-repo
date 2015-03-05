require 'chef/provisioning/aws_driver'

config_file = "/etc/chef/knife.rb"
Chef::Config.from_file(config_file)

with_chef_server Chef::Config[:chef_server_url], {
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]
}

log "*** Using chef environment: #{node['provision']['chef']['environment']}"

# Create an array of machine names
the_machines = []
for i in (1..node['provision']['instances'].to_i)
  the_machines.push("#{node['provision']['name_prefix']}-#{i}")
end

machine_batch do
  the_machines.each do |machine_name|
    machine machine_name do
      tag "name=#{machine_name}"
      run_list node['provision']['chef']['run_list'].split(/\s*,\s*/)
      chef_environment node['provision']['chef']['environment']
      machine_options({
        :ssh_username => 'root',
        :bootstrap_options => {
          :key_name => node['provision']['cloud']['key_name'],
          :availability_zone => node['provision']['cloud']['availability_zone'],
          :instance_type => node['provision']['cloud']['instance_type'],
          :image_id => node['provision']['cloud']['image_id']
        },
        :image_id => node['provision']['cloud']['image_id']
      })
    end
  end
  # other actions :converge, :destroy, :nothing
  action (node['provision']['all']=="true" ? :converge : :destroy)
end

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
