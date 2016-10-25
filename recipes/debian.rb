#
# Cookbook Name:: signalsciences
# Recipe:: ubuntu
#
# Copyright (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

package 'apt-transport-https'

apt_repository 'sigsci-release' do
  uri "https://apt.signalsciences.net/release/#{node['platform']}"
  distribution node['lsb']['codename']
  components ['main']
  key 'https://apt.signalsciences.net/gpg.key'
end

# If auto update mode is enabled periodically update the apt metadata cache
# for the sigsci repo only. How frequently this occurs is configured by
# the cache_refresh_interval attribute, by default we refresh hourly.
cache_refresh_interval = node['signalsciences']['cache_refresh_interval']
cache_sentinel_file = node['signalsciences']['cache_sentinel_file']

if node['signalsciences']['agent_auto_update'] || node['signalsciences']['apache_module_auto_update'] || node['signalsciences']['nginx_lua_module_auto_update']
  script 'apt-expire_cache-sigsci_release_repo' do
    interpreter 'bash'
    code <<-EOS
    apt-get update -o Dir::Etc::sourcelist="sources.list.d/sigsci-release.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
    NOW=$(date "+%s")
    NEXT_REFRESH=$(( $NOW + #{cache_refresh_interval} ))
    echo $NEXT_REFRESH > #{cache_sentinel_file}
    EOS
    only_if "[ ! -f #{cache_sentinel_file} ] || [ $(date +%s) -gt $(cat #{cache_sentinel_file}) ]"
  end
end
