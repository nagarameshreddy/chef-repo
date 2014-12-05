name "linux_apache"
description "Linux apache role"
run_list "recipe[myapache-cookbook::default]", 
         "recipe[myapache-cookbook::app-checkout]"
