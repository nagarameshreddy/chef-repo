#
# Cookbook Name:: mysecurity-cookbook
# Recipe:: packages
#

include_recipe 'myohai-plugins-cookbook::bash_version'

log '*** In mysecurity-cookbook::packages recipe'

bash 'Checking if bash is vulnerable' do
  flags '-ex'
  cwd '/tmp'
  code <<-'EOH'
    env x='() { :;}; echo vulnerable' bash -c "echo this is a test" > /tmp/bash.txt
    bash -version >> /tmp/bash.txt
  EOH
end

log "*** Bash vulnerable: #{node['languages']['bash']['shellshock_vulnerable']}"


