log '*** This is the install_google_chrome::default recipe'

if (Time.now.hour == 1)
  log '*** Time is 1am, time to do some work'
else
  log '*** This is not 1am, skipping work'
end

directory 'C:\MyKits\test1am' do
  recursive true
  only_if { Time.now.hour == 1 }
  action :create
end

# Creates a directory with proper permissions
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Chrome' do
  action :create
  recursive true
end

remote_file 'C:\MyKits\Chrome\GoogleChromeStandaloneEnterprise.msi' do
  source node['chrome']['url']
  checksum node['chrome']['checksum']
  action :create
end

# http://docs.opscode.com/resource_batch.html
batch 'Output directory list' do
  code 'dir C:\MyKits\Chrome'
  action :run
end

# Install Chrome using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Chrome\GoogleChromeStandaloneEnterprise.msi'
  action :install
end

windows_path 'C:\Program Files (x86)\Google\Chrome\Application' do
  action :add
end
