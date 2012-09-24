module SilverSpoon
  module Entitlements
    # Add an entitlement for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_key [String] Entitlement key.
    # @param entitlement_value [String] Entitlement value.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    def add_entitlement(id, entitlement_key, entitlement_value, scope = SilverSpoon.default_scope)
      add_entitlements(id, [entitlement_key], [entitlement_value], scope)
    end

    # Add multiple entitlements for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_keys [Array of String] Entitlement keys.
    # @param entitlement_values [Array of String] Entilement values.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    def add_entitlements(id, entitlement_keys, entitlement_values, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.hmset(silver_spoon_key(id, SilverSpoon.namespace, scope), *entitlement_keys.zip(entitlement_values).flatten!)
    end

    # Remove an entitlement for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_key [String] Entitlement key.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    def remove_entitlement(id, entitlement_key, scope = SilverSpoon.default_scope)
      remove_entitlements(id, [entitlement_key], scope)
    end

    # Remove multiple entitlements for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_keys [Array of String] Entitlement keys.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    def remove_entitlements(id, entitlement_keys, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.multi do |transaction|
        entitlement_keys.each do |entitlement_key|
          transaction.hdel(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
        end
      end
    end

    # Retrieve an entitlement for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_key [String] Entitlement key.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    #
    # @return Hash of entitlement key to entitlement value.
    def retrieve_entitlement(id, entitlement_key, scope = SilverSpoon.default_scope)
      retrieve_entitlements(id, [entitlement_key], scope)
    end

    # Retrieve a set of entitlements for a given +id+.
    #
    # @param id [String] Identifier.
    # @param entitlement_keys [Array of String] Entitlement keys.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    #
    # @return Hash of entitlement keys to entitlement values.
    def retrieve_entitlements(id, entitlement_keys, scope = SilverSpoon.default_scope)
      Hash[*entitlement_keys.zip(SilverSpoon.redis.hmget(silver_spoon_key(id, SilverSpoon.namespace, scope), *entitlement_keys)).flatten!]
    end

    # Check to see if a given +id+ has a given entitlement.
    #
    # @param id [String] Identifier.
    # @param entitlement_key [String] Entitlement key.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    #
    # @return +true+ if the +id+ has the requested entitlement, +false+ otherwise.
    def has_entitlement?(id, entitlement_key, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.hexists(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
    end

    # Check to see if a given +id+ has a given set of entitlements.
    #
    # @param id [String] Identifier.
    # @param entitlement_keys [Array of String] Entitlement keys.
    # @param scope [String, SilverSpoon.default_scope] Scope.
    #
    # @return Array where +true+ if the +id+ has the requested entitlement, +false+ otherwise for each entitlement.
    def has_entitlements?(id, entitlement_keys, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.multi do |transaction|
        entitlement_keys.each do |entitlement_key|
          transaction.hexists(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
        end
      end
    end

    private

    # Helper method for SilverSpoon keys in form of +id:namespace:scope+.
    #
    # @param id [String] Identifier.
    # @param namespace [String] Namespace.
    # @param scope [String] Scope.
    #
    # @return Key in form of +id:namespace:scope+.
    def silver_spoon_key(id, namespace, scope)
      "#{namespace}:#{scope}:#{id}"
    end
  end
end