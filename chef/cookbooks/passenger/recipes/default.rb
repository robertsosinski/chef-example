package "libcurl4-openssl-dev"

ruby_version = "2.0.0"
passenger_version = "4.0.7"

gem_package "passenger" do
  version passenger_version
end

execute "build nginx" do
  command "passenger-install-nginx-module" <<
    " --auto" <<
    " --auto-download" <<
    " --prefix=/opt/nginx"

  not_if "test -f /opt/nginx/sbin/nginx"
  not_if "gem list | grep 'passenger (#{passenger_version})'"
end

template "/opt/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
  mode  "0644"
  owner "root"
  group "root"

  variables :ruby_version => ruby_version,
            :passenger_version => passenger_version,
            :rails_env => node.env

  notifies :reload, "service[nginx]"
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end