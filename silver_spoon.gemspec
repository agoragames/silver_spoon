# -*- encoding: utf-8 -*-
require File.expand_path('../lib/silver_spoon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Czarnecki"]
  gem.email         = ["dczarnecki@agoragames.com"]
  gem.description   = %q{Entitlements in Redis}
  gem.summary       = %q{Entitlements in Redis. A simple wrapper around Redis hashes for adding, removing, and checking existence of entitlements.}
  gem.homepage      = "https://github.com/agoragames/silver_spoon"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "silver_spoon"
  gem.require_paths = ["lib"]
  gem.version       = SilverSpoon::VERSION

  gem.add_dependency 'redis'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
