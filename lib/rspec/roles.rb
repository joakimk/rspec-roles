require "rspec/roles/version"
require "rspec/roles/implements_role"
require "singleton"

module RSpec
  module Roles
    def self.define(&block)
      role_set.reset!
      role_set.instance_eval(&block)
    end

    def self.roles
      role_set.to_hash
    end

    private

    def self.role_set
      RoleSet.instance
    end

    class RoleSet
      include Singleton

      def role(name, method_opts)
        @roles ||= {}
        @roles[name] = resolve(method_opts)
      end

      def reset!
        @roles = {}
      end

      def to_hash
        @roles
      end

      private

      def resolve(method_opts)
        if method_opts.is_a?(Array)
          method_opts.inject({}) { |h, method_name| h.merge!(method_name => []) }
        else
          method_opts
        end
      end
    end
  end
end
