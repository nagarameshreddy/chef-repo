name "windows_jenkins"
description "Windows jenkins role"
run_list ["recipe[java::default]","recipe[jenkins-windows::_master_war]"]
override_attributes({
  'java' => {
	  'windows' => {
		  'url' => 'https://s3-eu-west-1.amazonaws.com/apop-bucket/jre-8u25-windows-i586.exe'
	  }
	},
	'jenkins' => {
    'master' => {
		  'home' => 'c:\jenkins',
			'log_directory' => 'c:\jenkins\logs'
    }
  }
})
