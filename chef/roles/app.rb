name "app"
description "A Ruby Application Server"

run_list ["recipe[sudoers]", "recipe[deploy-user]", "recipe[ruby]", "recipe[passenger]"]