# Run chef-provisioning to create AWS ELB and instances using chef-provisioning
export CHEF_DRIVER=aws
cd hosted_aws_demo
chef-client -z apache_demo.rb -j attrs.json
