# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec/roles/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joakim Kolsjö"]
  gem.email         = ["joakim.kolsjo@gmail.com"]
  gem.description   = %q{A library for testing duck-typed roles inspired by Practical Object-Oriented Design In Ruby.}
  gem.summary       = %q{A library for testing duck-typed roles inspired by Practical Object-Oriented Design In Ruby.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rspec-roles"
  gem.require_paths = ["lib"]
  gem.version       = RSpec::Roles::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "rake"
end
