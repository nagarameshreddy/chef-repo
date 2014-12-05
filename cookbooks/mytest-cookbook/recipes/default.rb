#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
  action :install
end

service 'httpd' do
  action [:enable, :start]
end

# Disable the default virtual host
execute 'mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled' do
  only_if do
    File.exist?('/etc/httpd/conf.d/welcome.conf')
  end
  notifies :restart, 'service[httpd]'
end

search('apache_sites', '*.*').each do |site|
  log '**** Test2'
end

search('apache_sites', '*:*').each do |site|
  apache_vhost site['id'] do
    site_port site['port']
    action :create
    notifies :restart, 'service[httpd]'
  end
end
