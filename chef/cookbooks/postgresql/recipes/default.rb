postgresql_version = "9.2"

package "python-software-properties"

execute "update-apt" do
  action :nothing

  command "apt-get update"
end

file "/etc/apt/sources.list.d/pgdg.list" do
  action :create_if_missing

  content "deb http://apt.postgresql.org/pub/repos/apt/ squeeze-pgdg main"
  owner "root"
  group "root"
  mode  "0644"

  notifies :run, "execute[update-apt]", :immediately
end

package "postgresql-#{postgresql_version}"
package "postgresql-contrib-#{postgresql_version}"
package "postgresql-server-dev-#{postgresql_version}"

template "/etc/postgresql/#{postgresql_version}/main/pg_hba.conf" do
  source "pg_hba.conf.erb"

  owner "postgres"
  group "postgres"
  mode  "0640"

  variables :chef_test => "testing 123"

  notifies :reload, "service[postgresql]"
end

template "/etc/postgresql/#{postgresql_version}/main/postgresql.conf" do
  source "postgresql.conf.erb"

  owner "postgres"
  group "postgres"
  mode  "0644"

  variables :chef_test => "testing 456"

  notifies :reload, "service[postgresql]"
end

service "postgresql" do
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [:enable, :start]
end