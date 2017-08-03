## ------------------------------------------------------------------
## AGENT CONFIGURATION
# ------------------------------------------------------------------
# agent site keys
default['signalsciences']['access_key'] = ''
default['signalsciences']['secret'] = ''

# optional configuration settings
default['signalsciences']['client_ip_header'] = ''

# attribute to pin agent version by default install latest
default['signalsciences']['agent_version'] = ''

# enable to auto update agent as new versions become available
default['signalsciences']['agent_auto_update'] = false

# allow override of agent listener socket
default['signalsciences']['rpc_address'] = ''

# debug flags
default['signalsciences']['debug'] = {
  'log-web-inputs' => 0,
  'log-web-outputs' => 0,
  'log-uploads' => 0,
}

## ------------------------------------------------------------------
## APACHE MODULE CONFIGURATION
## ------------------------------------------------------------------
# attribute to pin apache module version by default install latest
default['signalsciences']['apache_module_version'] = ''
default['signalsciences']['apache_module_path'] = '/etc/httpd/modules'
default['signalsciences']['apache_module_conf_path'] = '/etc/httpd/conf.d'

# enable to auto update apache module as new versions become available
default['signalsciences']['apache_module_auto_update'] = false

## ------------------------------------------------------------------
## NGINX MODULE CONFIGURATION
## ------------------------------------------------------------------
default['signalsciences']['nginx_lua_module_version'] = ''
default['signalsciences']['nginx_lua_module_auto_update'] = false

## ------------------------------------------------------------------
## INTERNAL CONFIG
## ------------------------------------------------------------------
# auto update configuration options
default['signalsciences']['cache_refresh_interval'] = 3600 # seconds
default['signalsciences']['cache_sentinel_file'] = '/tmp/sigsci-repo.next_cache_refresh'
