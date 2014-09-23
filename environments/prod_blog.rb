name "prod_blog"
description "Prod blog environment"
cookbook "haproxy", "= 1.6.6"
default_attributes "haproxy" => {
                                       "incoming_address" => "1.1.1.1"
}
override_attributes "haproxy" => {
                                       "incoming_port" => "82"
}
