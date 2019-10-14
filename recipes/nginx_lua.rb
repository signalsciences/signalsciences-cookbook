# frozen_string_literal: true

#
# Cookbook:: signalsciences
# Recipe:: nginx-lua
#
# Copyright:: (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe 'signalsciences::common'

# if auto_update is enabled package action will be set to upgrade
install_action = if node['signalsciences']['nginx_lua_auto_update']
                   :upgrade
                 else
                   :install
                 end

# installs the sigsci-agent package and pins version if agent_version is set
package 'sigsci-nginx-lua-module' do
  version node['signalsciences']['nginx_lua_module_version'] unless node['signalsciences']['nginx_lua_module_version'].empty?
  action install_action
end
