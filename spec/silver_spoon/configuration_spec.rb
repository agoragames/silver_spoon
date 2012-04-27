require 'spec_helper'

describe SilverSpoon::Configuration do
  describe '#configure' do
    it 'should have default attributes' do
      SilverSpoon.configure do |configuration|
        configuration.namespace.should == 'silver_spoon'
        configuration.default_scope.should == 'entitlements'
      end
    end
  end
end