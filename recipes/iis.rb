# frozen_string_literal: true

#
# Cookbook Name:: signalsciences
# Recipe:: iis
#

windows_package 'sigsci-module-iis_latest.msi' do
  source 'https://dl.signalsciences.net/sigsci-module-iis/sigsci-module-iis_latest.msi'
  action :install
end
