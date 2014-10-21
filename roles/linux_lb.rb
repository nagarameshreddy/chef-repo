name "linux_lb"
description "Linux load balancer role"
# Version pin example:
#run_list "recipe[haproxy::default@1.6.6]"
run_list "recipe[haproxy::default]"
