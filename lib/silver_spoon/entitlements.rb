module SilverSpoon
  module Entitlements
    def add_entitlement(id, entitlement_key, entitlement_value, scope = SilverSpoon.default_scope)
      add_entitlements(id, [entitlement_key], [entitlement_value], scope)
    end

    def add_entitlements(id, entitlement_keys, entitlement_values, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.hmset(silver_spoon_key(id, SilverSpoon.namespace, scope), *entitlement_keys.zip(entitlement_values).flatten!)
    end

    def remove_entitlement(id, entitlement_key, scope = SilverSpoon.default_scope)
      remove_entitlements(id, [entitlement_key], scope)
    end

    def remove_entitlements(id, entitlement_keys, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.multi do |transaction|
        entitlement_keys.each do |entitlement_key|
          transaction.hdel(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
        end
      end
    end

    def has_entitlement?(id, entitlement_key, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.hexists(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
    end

    def has_entitlements?(id, entitlement_keys, scope = SilverSpoon.default_scope)
      SilverSpoon.redis.multi do |transaction|
        entitlement_keys.each do |entitlement_key|
          transaction.hexists(silver_spoon_key(id, SilverSpoon.namespace, scope), entitlement_key)
        end
      end.map { |value| value == 0 ? false : true }
    end

    private 

    def silver_spoon_key(id, namespace, scope)
      "#{namespace}:#{scope}:#{id}"
    end
  end
end