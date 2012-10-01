Feature: Running tests based on a role on a class that implements it

  Background:
    Given a file named "spec_helper.rb" with:
      """
        require 'rspec/roles'

        RSpec::Roles.define do
          role :preparer, { :prepare_trip => [ :trip ] }
        end
      """

  Scenario: A successful test run
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Mechanic
          def prepare_trip(trip)
          end
        end

        describe Mechanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should pass

  Scenario: When a method is not defined at all
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Mechanic
        end

        describe Mechanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should fail

  Scenario: When a method is defined but with the wrong number of arguments
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Mechanic
          def prepare_trip(trip, foo)
          end
        end

        describe Mechanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should fail

  Scenario: When a method is defined with no arguments when arguments are required
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Mechanic
          def prepare_trip
          end
        end

        describe Mechanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should fail

  Scenario: When a method is defined with no arguments when arguments are not required
    Given a file named "spec_helper.rb" with:
      """
        require 'rspec/roles'

        RSpec::Roles.define do
          role :preparer, [ :prepare_trip ]
        end
      """
    And a file named "mechanic_spec.rb" with:
      """
        require "spec_helper.rb"

        class Mechanic
          def prepare_trip
          end
        end

        describe Mechanic do
          implements_role :preparer
        end
      """
    When I run "rspec -I . -I ../lib -rubygems mechanic_spec.rb"
    Then the examples should pass
