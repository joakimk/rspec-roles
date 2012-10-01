require "rspec/roles/version"
require "singleton"

module RSpec
  module Roles
    def self.define(&block)
      RoleSet.instance.instance_eval(&block)
    end

    def self.roles
      RoleSet.instance.to_hash
    end

    private

    class RoleSet
      include Singleton

      def role(name, opts)
        @roles ||= {}
        @roles[name] = opts
      end

      def to_hash
        @roles
      end
    end

  end
end
