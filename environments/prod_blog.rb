name "prod_blog"
description "Prod blog environment"i

cookbook "haproxy", "= 1.6.6"
cookbook "myapache-cookbook", "= 0.2.10"

override_attributes(
    'myapache-cookbook' => {
				         'git-repo' => 'https://github.com/alexpop/myapache-app',
                 'git-revision' => '76bbc80189b0dd2341035da28140a08697d9a507' }
)

