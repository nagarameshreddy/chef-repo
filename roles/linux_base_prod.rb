name "linux_base_prod"
description "Linux base role for production nodes"
run_list "recipe[chef-client::delete_validation]",
         "recipe[chef-client::default]"
override_attributes(
	    'chef_client' => {
	        'interval' => '300' }
)
