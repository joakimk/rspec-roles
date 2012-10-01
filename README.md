# This is a work in progress. Alpha-level code. May not support the things written below.

![Build status](https://secure.travis-ci.org/joakimk/rspec-roles.png)

# Rspec::Roles

A library for testing duck-typed roles inspired by Practical Object-Oriented Design In Ruby.

## About

Ruby does not have interfaces. And that's a good thing. Duck-typing is great!

However: would it not be nice if you could find all places where a method is used by just running your (surely sub-second?) unit test suite?

This library let's you define roles and generates tests to ensure that when you change the role, you can quickly fix all classes that implements it.

## Support

It only supports ruby 1.9 for now.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-roles'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-roles

## Usage

In the spec file, instead of using *mock* or *double* you do:

    preparer = role_double(:preparer)

    # You can do this
    preparer.should_receive(:prepare_trip).with(5)

    # But this throws an error (to ensure you don't change the signature without updating the role)
    preparer.should_receive(:prepare_marathon).with(5)

Then in **spec/spec_helper.rb**:

    Rspec::Roles.define do
      role :preparer, { :prepare_trip => [ :trip ] }
      # role :preparable, [ :bicycles, :customers, :vehicle ]
    end

And everywhere that implements the preparer role you do:

    describe Mechanic do
      implements_role :preparer
    end

    # This generates tests like this:

    #describe Mechanic do
    #  context "implements the preparer role by" do
    #    it "responding to prepare_trip with the 1 required argument" do
    #      subject.should respond_to(:prepare_trip)
    #      # todo: subject.method(:prepare_trip).parameters...
    #    end
    #  end
    #end

If you use spork and want it to reload the role definitions on each run, place the definitions in a file like "spec/support/rspec_roles.rb" and do this:

    Spork.each_run do
      load "#{Rails.root}/spec/support/rspec_roles.rb"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
