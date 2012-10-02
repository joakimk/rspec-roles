require "rspec/roles/version"
require "rspec/roles/implements_role"
require "rspec/roles/role_set"

module RSpec
  module Roles
    def self.define(&block)
      role_set.apply(&block)
    end

    def self.roles
      role_set.to_hash
    end

    private

    def self.role_set
      RoleSet.instance
    end
  end
end
