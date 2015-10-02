# Policyfile.rb - Describe how you want Chef to build your system.

# A name that describes what the system you're building with Chef does.
name "myapache-policy"

# Where to find external cookbooks:
default_source :supermarket

# Where to find internal cookbooks and version constraints
cookbook "myapache-cookbook", path: "~/git/myapache-cookbook"
cookbook "chef-client", "= 4.3.1"

# chef-client will run these recipes in the order specified.
run_list "chef-client::default", 
         "chef-client::config",
         "myapache-cookbook::reason",
         "myapache-cookbook::default",
         "myapache-cookbook::app_checkout",
         "myapache-cookbook::ssl",
         "myapache-cookbook::audit_tests"

# Define attributes with the `default` order of precedence
default['chef_client']['interval'] = "900"
default['chef_client']['splay'] = "150"
default['chef_client']['config']['audit_mode'] = "enabled"
default['myapache-cookbook']['git-repo'] = 'https://github.com/alexpop/myhtml-app'
default['myapache-cookbook']['git-revision'] = 'release-3'
default['data_bag']['name'] = 'secure'
default['data_bag']['item'] = 'ssl_opschef_tv'
default['data_bag']['secret'] = 'superSECRETencryptionKEY'

# Let's play with a bit of ruby here
mytime=Time.now
default['myapache-cookbook']['reason'] = "Policy update by #{ENV['USER']} on #{mytime}`"
