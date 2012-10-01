require 'spec_helper'
require 'rspec/roles'

describe RSpec::Roles, "self.define" do
  it "defines a set of roles" do
    RSpec::Roles.define do
      role :order_client, { :order_successful => [ :message ], :order_failed => [ :message ] }
    end

    RSpec::Roles.roles.should == {
      :order_client => { :order_successful => [ :message ], :order_failed => [ :message ] }
    }
  end

  # useful when you run spork and need to make changes without restarting the entire process
  it "is possible to reset roles" do
    RSpec::Roles.define do
      role :order_client, { :order_successful => [ :message ], :order_failed => [ :message ] }
    end

    RSpec::Roles.define do
    end

    RSpec::Roles.roles.keys.size.should == 0
  end

  it "supports method definition by array" do
    RSpec::Roles.define do
      role :order_client, [ :order_successful, :order_failed ]
    end

    RSpec::Roles.roles.should == {
      :order_client => { :order_successful => [], :order_failed => [] }
    }
  end
end
