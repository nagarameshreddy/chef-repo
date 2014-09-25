name "linux_lb_v1"
description "Load Balancer node"
run_list "recipe[haproxy::default@1.6.6]"
default_attributes "haproxy" => {
                                       "incoming_port" => "81"
}
