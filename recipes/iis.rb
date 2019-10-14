# frozen_string_literal: true

#
# Cookbook:: signalsciences
# Recipe:: iis
#

windows_feature 'Web-Server' do
  all true
  action :install
  install_method :windows_feature_powershell
end

windows_package 'sigsci-module-iis_latest.msi' do
  source 'https://dl.signalsciences.net/sigsci-module-iis/sigsci-module-iis_latest.msi'
  action :install
end
