name "linux_web_prod"
description "Linux webserver role for production nodes"
run_list "recipe[myapache-cookbook::default]", 
         "recipe[myapache-cookbook::app-checkout]"
