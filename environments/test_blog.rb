name 'test_blog'
description 'Test blog environment'

cookbook_versions({
  'haproxy'=>'= 1.6.6',
  'myapache-cookbook'=>'= 0.2.10'
})

override_attributes({
  'myapache-cookbook' => {
    'git-repo' => 'https://github.com/alexpop/myapache-app',
    'git-revision' => 'b61978bf02116fde8b09cf62a0540ab6c6d08ada' 
  },
  'java' => {
		'windows' => {
		  'url' => 'https://s3-eu-west-1.amazonaws.com/apop-bucket/jre-8u25-windows-i586.exe'
	  }
  }
})
