#
# Cookbook Name:: signalsciences
# Recipe:: apache24
#
# Copyright (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'signalsciences::common'

# by default install the package unless auto_update is enabled
if node['signalsciences']['apache_module_auto_update']
  pkg_action = :upgrade
else
  pkg_action = :install
end

package 'sigsci-module-apache' do
  unless node['signalsciences']['apache_module_version'].empty?
    version node['signalsciences']['apache_module_version']
  end
  action pkg_action
end

conf_path = node['signalsciences']['apache_module_conf_path']
template "#{conf_path}/sigsci.conf" do
  source 'apache_module.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end
