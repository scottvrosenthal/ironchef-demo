name "web_server"
description "Web Server Role"
run_list('recipe[commons]', 'recipe[commons::nginx]')
default_attributes('nginx' => { 'version' => '1.4.2-1.el6.ngx' })