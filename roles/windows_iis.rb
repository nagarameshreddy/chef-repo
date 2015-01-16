name "windows_iis"
description "Windows webserver role based on IIS"
run_list "recipe[myiis-cookbook::default]", 
         "recipe[myiis-cookbook::app-checkout]"

