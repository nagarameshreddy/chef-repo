name 'prod_blog'
description 'Prod blog environment'

cookbook_versions({
  'haproxy'=>'= 1.6.6',
  'myapache-cookbook'=>'= 0.2.10'
})

override_attributes({
  'myapache-cookbook' => {
    'git-repo' => 'https://github.com/alexpop/myhtml-app',
    'git-revision' => 'release-2' 
  },
  'chef_client' => {
    'interval' => '60'
  }
})

