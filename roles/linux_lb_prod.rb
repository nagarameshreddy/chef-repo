name "linux_lb_prod"
description "Linux load balancer role for production nodes"
# Version pin example:
#run_list "recipe[haproxy::default@1.6.6]"
run_list "recipe[haproxy::default]"
