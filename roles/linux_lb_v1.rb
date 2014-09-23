name "linux_lb_v1"
description "Load Balancer node"
run_list "recipe[haproxy::default]"
default_attributes "haproxy" => {
                                       "incoming_port" => "81"
}
