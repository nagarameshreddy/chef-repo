require 'chef/provisioning/vagrant_driver'

vagrant_box 'centos66' do
  url 'http://vagrantcloud.com/chef/boxes/centos-6.6/versions/1.0.0/providers/virtualbox.box'
end

with_machine_options :vagrant_options => {
  'vm.box' => 'centos66',
	'vm.hostname' => 'marioxxx'
}
