# SilverSpoon

Entitlements in Redis. A simple wrapper around Redis hashes for adding, removing, retrieving and 
checking existence of entitlements.

## Installation

Add this line to your application's Gemfile:

```
gem 'silver_spoon'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install silver_spoon
```

## Usage

Configuration:

```ruby
SilverSpoon.configure do |configuration|
  configuration.redis = Redis.new
  configuration.namespace = 'silver_spoon'
  configuration.default_scope = 'entitlements'
end
```

The hash key used in looking up entitlements for a given `id` is as follows:

```ruby
"#{SilverSpoon.namespace}:#{scope}:#{id}"
```

Adding entitlements:

```ruby
add_entitlement(id, entitlement_key, entitlement_value, scope = SilverSpoon.default_scope)
add_entitlements(id, entitlement_keys, entitlement_values, scope = SilverSpoon.default_scope)
```

Removing entitlements:

```ruby
remove_entitlement(id, entitlement_key, scope = SilverSpoon.default_scope)
remove_entitlements(id, entitlement_keys, scope = SilverSpoon.default_scope)
```

Checking entitlements:

```ruby
has_entitlement?(id, entitlement_key, scope = SilverSpoon.default_scope)
has_entitlements?(id, entitlement_keys, scope = SilverSpoon.default_scope)
```

Retrieving entitlements:

```ruby
retrieve_entitlement(id, entitlement_key, scope = SilverSpoon.default_scope)
retrieve_entitlements(id, entitlement_keys, scope = SilverSpoon.default_scope)
```

Complete example:

```ruby
require 'silver_spoon'
 => true 
SilverSpoon.configure do |configuration|
  configuration.redis = Redis.new
  configuration.namespace = 'silver_spoon'
  configuration.default_scope = 'entitlements'
end
 => "entitlements" 
SilverSpoon.has_entitlement?('david', 'an_entitlement')
 => false 
SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
 => "OK" 
SilverSpoon.add_entitlement('david', 'another_entitlement', 'another_entitlement_value')
 => "OK" 
SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement'])
 => [true, true] 
SilverSpoon.has_entitlement?('david', 'unknown_entitlement')
 => false 
SilverSpoon.retrieve_entitlements('david', ['an_entitlement', 'another_entitlement'])
 => {"an_entitlement"=>"an_entitlement_value", "another_entitlement"=>"another_entitlement_value"} 
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 David Czarnecki. See LICENSE for further details.
