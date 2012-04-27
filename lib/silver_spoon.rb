require 'redis'
require 'silver_spoon/configuration'
require 'silver_spoon/entitlements'
require 'silver_spoon/version'

module SilverSpoon
  extend Configuration
  extend Entitlements
end
