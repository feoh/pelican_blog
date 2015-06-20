#
# Cookbook Name:: pelican_blog
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "python"
include_recipe "nginx"

package "git"
python_pip "markdown"
python_pip "pelican"

bash "clean_house" do
  code <<-EOH
  rm -rf /tmp/blindnotdumb
  rm -rf /opt/blog
  EOH
end

directory "/opt"
directory "/opt/blog"
directory "/opt/blog/blindnotdumb"

cookbook_file "blindnotdumbsite" do
  path "/etc/nginx/sites-available/blindnotdumbsite"
  action :create_if_missing
end


nginx_site 'default' do
  enable false
end

nginx_site "blindnotdumbsite"

git "/tmp/blindnotdumb" do
  repository "https://github.com/feoh/blindnotdumb.git"
  enable_submodules true
  revision "master"
  action :sync
  notifies :run, "execute[publish_site]"
end




execute "publish_site" do
  cwd "/tmp/blindnotdumb"
  command "make publish"
  notifies :run, "execute[copy_site_dir]"
end

execute "copy_site_dir" do
  command "cp -r /tmp/blindnotdumb/output/* /opt/blog/blindnotdumb"
end


