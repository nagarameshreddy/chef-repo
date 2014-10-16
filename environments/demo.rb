name "demo"
description "Demo environment"

override_attributes(
	'chef_client' => {
	    'interval' => "300" },
	'myapache-cookbook' => {
			'name' => 'Demo John' }
)
