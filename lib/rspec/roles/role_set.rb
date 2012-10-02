require "singleton"

module RSpec
  module Roles
    class RoleSet
      include Singleton

      def apply(&block)
        reset
        instance_eval(&block)
      end

      def to_hash
        roles
      end

      private

      def role(name, method_opts)
        roles[name] = resolve(method_opts)
      end

      def roles
        @roles ||= {}
      end

      def reset
        @roles = {}
      end

      def resolve(method_opts)
        if method_opts.is_a?(Array)
          convert_to_hash(method_opts)
        else
          method_opts
        end
      end

      def convert_to_hash(method_opts)
        method_opts.inject({}) { |h, method_name| h.merge!(method_name => []) }
      end
    end
  end
end
