# Stay on the latest gems to benefit from latest features and bug fixes
chef gem list chef-provisioning
chef gem install chef-provisioning
chef gem install chef-provisioning-aws

# Run chef-provisioning to create AWS ELB and instances using chef-provisioning
export CHEF_DRIVER=aws
cd hosted_aws_demo
chef-client -z apache_demo.rb -j attrs.json
