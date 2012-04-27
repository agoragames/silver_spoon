require 'rspec'
require 'silver_spoon'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:all) do
    SilverSpoon.configure do |configuration|
      redis = Redis.new(:db => 15)
      configuration.redis = redis
    end
  end

  config.before(:each) do
    SilverSpoon.redis.flushdb
  end

  config.after(:all) do
    SilverSpoon.redis.flushdb
    SilverSpoon.redis.quit
  end
end