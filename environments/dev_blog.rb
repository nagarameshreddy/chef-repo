name 'dev_blog'
description 'Dev blog environment'
override_attributes({
  'myapache-cookbook' => {
           'git-repo' => 'https://github.com/alexpop/myapache-app',
           'git-revision' => 'master' }
})
