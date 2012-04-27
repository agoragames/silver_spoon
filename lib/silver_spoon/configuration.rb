module SilverSpoon
  module Configuration
    # Redis instance.
    attr_accessor :redis

    # silver_spoon namespace for Redis.
    attr_writer :namespace

    # Default scope for entitlements.
    attr_writer :default_scope
    
    # Yield self to be able to configure silver_spoon with block-style configuration.
    #
    # Example:
    #
    #   SilverSpoon.configure do |configuration|
    #     configuration.redis = Redis.new
    #     configuration.namespace = 'silver_spoon'
    #     configuration.default_scope = 'entitlements'
    #   end
    def configure
      yield self
    end

    # silver_spoon namespace for Redis.
    #
    # @return the silver_spoon namespace or the default of 'silver_spoon' if not set.
    def namespace
      @namespace ||= 'silver_spoon'
    end

    # Default scope for entitlements.
    #
    # @return the default scope for entitlements or the default of 'entitlements' if not set.
    def default_scope
      @default_scope ||= 'entitlements'
    end
  end
end
