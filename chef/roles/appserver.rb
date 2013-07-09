name "appserver"
description "A Ruby App Server"

run_list ["recipe[sudoers]", "recipe[ruby]", "recipe[passenger]"]