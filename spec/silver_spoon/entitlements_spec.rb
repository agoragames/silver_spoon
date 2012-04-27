require 'spec_helper'

describe SilverSpoon::Entitlements do
  describe '#add_entitlement ', '#has_entitlement?' do
    it 'should set an entitlement if not already set for a given id, entitlement_key and default scope' do
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_false
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
    end

    it 'should set an entitlement if not already set for a given id, entitlement_key and given scope' do
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_false
      SilverSpoon.has_entitlement?('david', 'an_entitlement', 'another_scope').should be_false
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value', 'another_scope')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_false
      SilverSpoon.has_entitlement?('david', 'an_entitlement', 'another_scope').should be_true
    end
  end

  describe '#add_entitlements' do
    it 'should allow you to set multiple entitlements at once' do
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
      SilverSpoon.add_entitlements('david', ['an_entitlement', 'another_entitlement'], ['an_entitlement_value', 'another_entitlement_value'])
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [true, true]
    end

    it 'should allow you to set multiple entitlements at once for a given scope' do
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement'], 'another_scope').should == [false, false]
      SilverSpoon.add_entitlements('david', ['an_entitlement', 'another_entitlement'], ['an_entitlement_value', 'another_entitlement_value'], 'another_scope')
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement'], 'another_scope').should == [true, true]
    end
  end

  describe '#remove_entitlement' do
    it 'should remove an entitlement' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
      SilverSpoon.remove_entitlement('david', 'an_entitlement')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_false
    end

    it 'should remove an entitlement from a given scope' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value', 'another_scope')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
      SilverSpoon.has_entitlement?('david', 'an_entitlement', 'another_scope').should be_true
      SilverSpoon.remove_entitlement('david', 'an_entitlement', 'another_scope')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
      SilverSpoon.has_entitlement?('david', 'an_entitlement', 'another_scope').should be_false
    end
  end

  describe '#remove_entitlements' do
    it 'should allow you to remove multiple entitlements at once' do
      SilverSpoon.add_entitlements('david', ['an_entitlement', 'another_entitlement'], ['an_entitlement_value', 'another_entitlement_value'])
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [true, true]
      SilverSpoon.remove_entitlements('david', ['an_entitlement', 'another_entitlement'])
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
    end

    it 'should allow you to remove multiple entitlements at once for a given scope' do
      SilverSpoon.add_entitlements('david', ['an_entitlement', 'another_entitlement'], ['an_entitlement_value', 'another_entitlement_value'])
      SilverSpoon.add_entitlements('david', ['an_entitlement', 'another_entitlement'], ['an_entitlement_value', 'another_entitlement_value'], 'another_scope')
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [true, true]
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement'], 'another_scope').should == [true, true]
      SilverSpoon.remove_entitlements('david', ['an_entitlement', 'another_entitlement'], 'another_scope')
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [true, true]
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement'], 'another_scope').should == [false, false]
    end
  end

  describe '#retrieve_entitlement' do
    it 'should retrieve an entitlement' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
      SilverSpoon.retrieve_entitlement('david', 'an_entitlement').should == {'an_entitlement' => 'an_entitlement_value'}
    end

    it 'should retrieve an entitlement for a given scope' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'another_entitlement_value', 'another_scope')
      SilverSpoon.has_entitlement?('david', 'an_entitlement').should be_true
      SilverSpoon.retrieve_entitlement('david', 'an_entitlement', 'another_scope').should == {'an_entitlement' => 'another_entitlement_value'}
    end
  end

  describe '#retrieve_entitlements' do
    it 'should retrieve multiple entitlements' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'another_entitlement', 'another_entitlement_value')
      SilverSpoon.retrieve_entitlements('david', ['an_entitlement', 'another_entitlement']).should == 
        {
          'an_entitlement' => 'an_entitlement_value', 
          'another_entitlement' => 'another_entitlement_value'
        }
    end

    it 'should retrieve multiple entitlements for a given scope' do
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'another_entitlement', 'another_entitlement_value')
      SilverSpoon.add_entitlement('david', 'an_entitlement2', 'an_entitlement_value', 'another_scope')
      SilverSpoon.add_entitlement('david', 'another_entitlement2', 'another_entitlement_value', 'another_scope')
      SilverSpoon.retrieve_entitlements('david', ['an_entitlement2', 'another_entitlement2', 'unknown_entitlement'], 'another_scope').should == 
        {
          'an_entitlement2' => 'an_entitlement_value', 
          'another_entitlement2' => 'another_entitlement_value',
          'unknown_entitlement' => nil
        }
    end
  end

  describe '#has_entitlements?' do
    it 'should allow you to check for multiple entitlements at once' do
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'another_entitlement', 'another_entitlement_value')
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement', 'unknown_entitlement']).should == [true, true, false]
    end

    it 'should allow you to check for multiple entitlements at once for a given scope' do
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement']).should == [false, false]
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value')
      SilverSpoon.add_entitlement('david', 'an_entitlement', 'an_entitlement_value', 'another_scope')
      SilverSpoon.add_entitlement('david', 'another_entitlement', 'another_entitlement_value')
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement', 'unknown_entitlement']).should == [true, true, false]
      SilverSpoon.has_entitlements?('david', ['an_entitlement', 'another_entitlement', 'unknown_entitlement'], 'another_scope').should == [true, false, false]
    end
  end
end