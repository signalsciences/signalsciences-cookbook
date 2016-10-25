#
# Cookbook Name:: signalsciences
# Recipe:: agent
#
# Copyright (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe 'signalsciences::common'

if node['signalsciences']['access_key'].empty? || node['signalsciences']['secret'].empty?
  Chef::Log.warn("Signal Sciences access or secret key attributes aren't set, not installing agent")
  return
end

# if auto_update is enabled package action will be set to upgrade
if node['signalsciences']['agent_auto_update']
  install_action = :upgrade
else
  install_action = :install
end

# installs the sigsci-agent package and pins version if agent_version is set
package 'sigsci-agent' do
  unless node['signalsciences']['agent_version'].empty?
    version node['signalsciences']['agent_version']
  end
  action install_action
  notifies :restart, 'service[sigsci-agent]', :delayed
end

directory '/etc/sigsci' do
  mode 0755
end

template '/etc/sigsci/agent.conf' do
  source 'agent.conf.erb'
  sensitive true
  mode 0644
  notifies :restart, 'service[sigsci-agent]', :immediately
end

service 'sigsci-agent' do
  # workaround for chef-client 11 handling of upstart services
  if node['platform_family'] == 'rhel' && node['platform_version'] =~ /^6/
    provider Chef::Provider::Service::Upstart
  end
  if node['platform_family'] == 'debian' && node['platform_version'] =~ /^1[24]/
    provider Chef::Provider::Service::Upstart
  end
  action [:enable, :start]
end
