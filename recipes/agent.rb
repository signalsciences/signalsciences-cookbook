# frozen_string_literal: true

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
install_action = if node['signalsciences']['agent_auto_update']
                   :upgrade
                 else
                   :install
                 end

# installs the sigsci-agent package and pins version if agent_version is set
if platform_family?('rhel', 'debian')
  package 'sigsci-agent' do
    unless node['signalsciences']['agent_version'].empty?
      version node['signalsciences']['agent_version']
    end
    action install_action
    notifies :restart, 'service[sigsci-agent]', :delayed
  end

  directory '/etc/sigsci' do
    mode 0o755
  end

  template '/etc/sigsci/agent.conf' do
    source 'agent.conf.erb'
    sensitive true
    mode 0o644
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
    action %i[enable start]
  end
elsif platform_family?('windows')
  directory 'C:\Program Files\Signal Sciences\Agent' do
    mode 0o755
    recursive true
    action :create
  end

  template 'C:\Program Files\Signal Sciences\Agent\agent.conf' do
    source 'agent.conf.erb'
    mode 0o755
  end

  windows_package 'sigsci-agent_latest.msi' do
    source 'https://dl.signalsciences.net/sigsci-agent/sigsci-agent_latest.msi'
    action :install
  end

  windows_service 'sigsci-agent' do
    action :start
  end
else
  warn "Signal Sciences applications aren't supported on this platform"
  return
end
