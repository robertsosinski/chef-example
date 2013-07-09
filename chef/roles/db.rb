name "db"
description "A PostgreSQL Server"

run_list ["recipe[sudoers]", "recipe[postgresql]"]