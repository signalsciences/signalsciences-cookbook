# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

LOG_LEVEL = :fatal
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '18.04',
  log_level: LOG_LEVEL,
  file_cache_path: '/tmp',
}.freeze
