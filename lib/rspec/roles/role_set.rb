require "singleton"

module RSpec
  module Roles
    class RoleSet
      include Singleton

      def apply(&block)
        @roles = {}
        instance_eval(&block)
      end

      def to_hash
        @roles
      end

      private

      def role(name, method_opts)
        @roles ||= {}
        @roles[name] = resolve(method_opts)
      end

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
