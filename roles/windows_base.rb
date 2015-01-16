name "windows_base"
description "Windows base role"
run_list "recipe[windows::default]"
override_attributes(
       'chef_client' => {
	        'interval' => '300' }
)
