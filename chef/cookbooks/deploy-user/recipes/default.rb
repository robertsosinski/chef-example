user "deploy" do
  home  "/home/deploy"
  shell "/bin/bash"

  supports :manage_home => true
end