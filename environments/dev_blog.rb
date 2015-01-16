name 'dev_blog'
description 'Dev blog environment'
override_attributes({
  'myapache-cookbook' => {
    'git-repo' => 'https://github.com/alexpop/myhtml-app',
    'git-revision' => 'master' 
  },
  'myiis-cookbook' => {
    'git-repo' => 'https://github.com/alexpop/myhtml-app',
    'git-revision' => 'release-1',
    'doc-root' => 'c:/inetpub/wwwroot'
  },
})
