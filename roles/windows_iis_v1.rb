name "windows_base_v1"
description "Base role applied to all Windows nodes."
run_list "recipe[chef-client::default]", "recipe[chef-client::delete_validation]"

override_attributes(
		'chef_client' => {
		    'interval' => '300' }
)
