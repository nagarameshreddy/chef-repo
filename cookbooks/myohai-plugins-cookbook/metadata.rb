name 'myohai-plugins-cookbook'
maintainer 'The Authors'
maintainer_email 'alex@example.com'
license 'all_rights'
description 'Installs/Configures myohai-plugins-cookbook'
long_description 'Installs/Configures myohai-plugins-cookbook'
version '0.1.0'

depends 'ohai', '= 2.0.1'

recipe 'myohai-plugins-cookbook::default', 'Default recipe'
recipe 'myohai-plugins-cookbook::bash_version', 'Install custom Ohai plugin to capture bash version and shellshock vulnerability'
