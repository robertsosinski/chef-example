ruby_version    = "2.0.0"
ruby_patchlevel = "p247"
ruby_filename   = "ruby-#{ruby_version}-#{ruby_patchlevel}"

package "build-essential"
package "git-core"
package "curl"
package "zlib1g-dev"
package "libssl-dev"
package "libreadline-dev"
package "libyaml-dev"
package "libsqlite3-dev"
package "sqlite3"
package "libxml2-dev"
package "libxslt-dev"

directory "/root/src" do
  action :create

  owner "root"
  group "root"
  mode  "0700"
end

remote_file "/root/src/#{ruby_filename}.tar.gz" do
  action :create_if_missing

  source "http://ftp.ruby-lang.org/pub/ruby/2.0/#{ruby_filename}.tar.gz"
end

execute "tar zxf #{ruby_filename}.tar.gz" do
  cwd     "/root/src"
  creates "/root/src/#{ruby_filename}"
end

extensions = ["bigdecimal", "curses", "openssl", "readline", "zlib"]

extensions.each do |ext|
  execute "building #{ext}" do
    cwd "/root/src/#{ruby_filename}/ext/#{ext}"
    command "ruby extconf.rb && make && make install"

    not_if "test -f /root/src/#{ruby_filename}/ext/#{ext}/Makefile"
  end
end

execute "./configure #{extensions.map{|ext| "--with-ext=#{ext}"}.join(" ")} && make && make install" do
  cwd "/root/src/#{ruby_filename}"
  creates "/usr/local/bin/ruby"

  not_if "ruby --version | grep 'ruby #{ruby_version}#{ruby_patchlevel}'"
end