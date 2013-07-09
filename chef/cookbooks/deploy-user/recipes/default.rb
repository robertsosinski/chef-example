user "deploy" do
  home "/home/deploy"
end

directory "/home/deploy" do
  action :create

  owner "deploy"
  group "deploy"
  mode  "0644"
end