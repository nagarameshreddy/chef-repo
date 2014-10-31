name 'mysecurity-cookbook'
maintainer 'Alex Pop'
maintainer_email 'alex@example.com'
license 'All rights reserved'
description 'Security related dev & test'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'myohai-plugins-cookbook', '= 0.1.0'

recipe 'mysecurity-cookbook::default', 'Default security recipe'
recipe 'mysecurity-cookbook::packages', 'Recipe to manage packages from a security perspective'
