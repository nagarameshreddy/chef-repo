name "windows_web"
description "Windows webserver role based on IIS"
run_list "recipe[iis::default]"
