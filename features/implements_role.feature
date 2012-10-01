Feature: Running tests based on a role on a class that implements it

  Scenario: A successful test run
    Given a file named "spec_helper.rb" with:
      """
        require 'rspec/roles'

        RSpec::Roles.define do
          role :preparer, { :prepare_trip => [ :trip ] }
        end
      """
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Metchanic
          def prepare_trip(trip)
          end
        end

        describe Metchanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should pass
