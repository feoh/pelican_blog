#
# Cookbook Name:: pelican_blog
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apt"
include_recipe "nginx"

directory "/opt"
directory "/opt/blog"
directory "/opt/blog/blindnotdumb"

package "git"

cookbook_file "blindnotdumbsite" do
  path "/etc/nginx/sites-available/blindnotdumbsite"
  action :create_if_missing
end


nginx_site "blindnotdumbsite"

git "/tmp/blindnotdumb" do
  repository "https://github.com/feoh/blindnotdumb.git"
  revision "master"
  action :sync
end

shell_out!("cp -r /tmp/blindnotdumb/content/* /opt/blog/blindnotdumb")


