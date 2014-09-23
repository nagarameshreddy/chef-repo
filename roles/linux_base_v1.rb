name "linux_base_v1"
description "Base role applied to all Linux nodes."
run_list "recipe[chef-client::default]", "recipe[chef-client::delete_validation]"
default_attributes "chef_client" => {
                                       "interval" => "300"
}
