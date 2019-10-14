# frozen_string_literal: true

#
# Cookbook:: signalsciences
# Spec:: default
#
# Copyright:: (c) 2016 The Authors, All Rights Reserved.

# The following are only examples, check out https://github.com/chef/inspec/tree/master/docs
# for everything you can do.

if os.debian? || os.redhat?
  describe service('sigsci-agent') do
    it { should be_running }
    it { should be_enabled }
  end
elsif os.windows?
  describe service('sigsci-agent') do
    it { should be_running }
    it { should be_enabled }
  end
  describe windows_feature('Web-Server') do
    it { should be_installed }
  end
  describe directory('C:\Program Files\Signal Sciences\IIS Module') do
    it { should exist }
  end
end
