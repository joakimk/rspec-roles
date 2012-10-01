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
end
