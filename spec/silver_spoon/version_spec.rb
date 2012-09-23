require 'spec_helper'

describe 'SilverSpoon::VERSION' do
  it 'should be the correct version' do
    SilverSpoon::VERSION.should == '0.0.2'
  end
end