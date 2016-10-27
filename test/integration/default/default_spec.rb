#
# Cookbook Name:: signalsciences
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# The following are only examples, check out https://github.com/chef/inspec/tree/master/docs
# for everything you can do.

describe port(80) do
  it { should_not be_listening }
end

describe port(443) do
  it { should_not be_listening }
end

describe yaml('.kitchen.yml') do
  its('driver.name') { should eq('vagrant') }
end
