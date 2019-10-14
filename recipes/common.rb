# frozen_string_literal: true

#
# Cookbook Name:: signalsciences
# Recipe:: common
#
# Copyright (C) 2016 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'rhel'
  include_recipe 'signalsciences::rhel'
when 'debian'
  include_recipe 'signalsciences::debian'
when 'windows'
  include_recipe 'signalsciences::iis'
else
  warn "Signal Sciences applications aren't supported on this platform"
  return
end
