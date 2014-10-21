name "linux_web"
description "Linux webserver role"
run_list "recipe[myapache-cookbook::default]", 
         "recipe[myapache-cookbook::app-checkout]"
