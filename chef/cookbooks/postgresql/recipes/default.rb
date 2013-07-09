package "python-software-properties"

execute "add postgres apt-get repository" do
  command "add-apt-repository http://apt.postgresql.org/pub/repos/apt/"

  not_if "cat /etc/apt/sources.list | grep 'http://apt.postgresql.org/pub/repos/apt/'"
end

execute "update apt" do
  command "apt-get update"
  action :nothing
end
