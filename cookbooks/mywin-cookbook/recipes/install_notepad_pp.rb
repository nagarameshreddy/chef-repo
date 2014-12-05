# Creates a directory with proper permissions
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Notepad' do
  action :create
  recursive true
end

# Download a remote file from the 'source' location if missing
remote_file 'C:\MyKits\Notepad\npp_installer.exe' do
  source node['notepadpp']['url']
  checksum node['notepadpp']['checksum']
end

# Run a batch command
# http://docs.opscode.com/resource_batch.html
batch 'Output directory list' do
  code 'dir C:\MyKits\Notepad'
  action :run
end

# Install Notepad++ using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Notepad++' do
  source 'C:\MyKits\Notepad\npp_installer.exe'
  installer_type :custom
  options '/S'
  action :install
end
