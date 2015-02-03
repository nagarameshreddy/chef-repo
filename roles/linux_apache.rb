name "linux_apache"
description "Linux apache role"
run_list "role[linux_base]",
         "recipe[myapache-cookbook::default]", 
         "recipe[myapache-cookbook::app-checkout]"
