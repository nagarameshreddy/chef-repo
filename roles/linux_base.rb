name "linux_base"
description "Linux base role"
run_list "recipe[chef-client::delete_validation]",
         "recipe[chef-client::default]"
override_attributes(
       'chef_client' => {
          'interval' => '300' }
)
