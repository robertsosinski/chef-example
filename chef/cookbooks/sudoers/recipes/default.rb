cookbook_file "/etc/sudoers" do
  source "sudoers"

  owner "root"
  group "root"
  mode  "0440"
end