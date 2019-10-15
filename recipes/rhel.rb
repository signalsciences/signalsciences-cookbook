# frozen_string_literal: true

#
# Cookbook:: signalsciences
# Recipe:: rhel
#
# Copyright:: (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#

dist_release = node['platform_version'].gsub(/^(\d)\..*/, '\1')

# workaround for apache httpd under systemd. Under systemd httpd runs with
# private tmp enabled by default so we can't see our unix domain socket
node.default['signalsciences']['rpc_address'] = 'unix:/var/run/sigsci-lua' if dist_release == '7' && node['signalsciences']['rpc_address'].empty?

template '/etc/yum.repos.d/sigsci-release.repo' do
  source 'yum.sigsci-release.repo.erb'
  variables 'dist_release' => dist_release
  notifies :run, 'execute[yum-makecache-sigsci_release]', :immediately
end

execute 'yum-makecache-sigsci_release' do
  command 'yum -q makecache -y --disablerepo=* --enablerepo=sigsci_*'
  action :nothing
end

# If auto update mode is enabled periodically clean the yum metadata cache
# for the sigsci repo only. How frequently this occurs is configured by
# the cache_refresh_interval attribute, by default we refresh hourly.
cache_refresh_interval = node['signalsciences']['cache_refresh_interval']
cache_sentinel_file = node['signalsciences']['cache_sentinel_file']

if node['signalsciences']['agent_auto_update'] || node['signalsciences']['apache_module_auto_update'] || node['signalsciences']['nginx_lua_module_auto_update']
  script 'yum-expire_cache-sigsci_release_repo' do
    interpreter 'bash'
    code <<-EOS
    yum -q clean --disablerepo=* --enablerepo=sigsci_release expire-cache
    NOW=$(date "+%s")
    NEXT_REFRESH=$(( $NOW + #{cache_refresh_interval} ))
    echo $NEXT_REFRESH > #{cache_sentinel_file}
    EOS
    only_if "[ ! -f #{cache_sentinel_file} ] || [ $(date +%s) -gt $(cat #{cache_sentinel_file}) ]"
  end
end
