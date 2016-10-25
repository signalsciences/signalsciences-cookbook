name 'signalsciences'
maintainer 'Signal Sciences Corp.'
maintainer_email 'support@signalsciences.com'
license 'all_rights'
description 'Installs/Configures signalsciences'
long_description 'Installs/Configures signalsciences'
version '0.3.0'
chef_version '>= 12'
issues_url 'https://github.com/signalsciences/signalsciences-cookbook/issues'
source_url 'https://github.com/signalsciences/signalsciences-cookbook'

%w( rhel centos ubuntu debian ).each do |os|
  supports os
end

depends 'apt'
