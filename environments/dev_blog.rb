name 'dev_blog'
description 'Dev blog environment'
override_attributes({
  'myapache-cookbook' => {
    'git-repo' => 'https://github.com/alexpop/myapache-app',
    'git-revision' => 'master' 
  },
  'java' => {
    'windows' => {
      'url' => 'https://s3-eu-west-1.amazonaws.com/apop-bucket/jre-8u25-windows-i586.exe'
    }
  }
})
