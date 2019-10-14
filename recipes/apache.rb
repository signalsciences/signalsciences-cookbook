# frozen_string_literal: true

#
# Cookbook:: signalsciences
# Recipe:: apache24
#
# Copyright:: (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'signalsciences::common'

# by default install the package unless auto_update is enabled
pkg_action = if node['signalsciences']['apache_module_auto_update']
               :upgrade
             else
               :install
             end

package 'sigsci-module-apache' do
  version node['signalsciences']['apache_module_version'] unless node['signalsciences']['apache_module_version'].empty?
  action pkg_action
end

conf_path = node['signalsciences']['apache_module_conf_path']
template "#{conf_path}/sigsci.conf" do
  source 'apache_module.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
