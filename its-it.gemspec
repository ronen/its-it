$:.push File.expand_path("../lib", __FILE__)
require 'its-it/version'

Gem::Specification.new do |s|
  s.name = 'its-it'
  s.version = ItsIt::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = "2011-04-26"
  s.authors = ['Ronen Barzel']
  s.email = 'ronen@barzel.org'
  s.homepage = 'http://github.com/ronen/its-it'
  s.summary = %q{Defines its() and it() method-chain proxies.}
  s.description = %q{
This gem defines the Kernel method "it" that queue and defer method calls.
This extends the Symbol#to_proc idiom to support chaining multiple methods.
For example, items.collect(&it.to_s.capitalize).  This also allows
conditionals in case statements, such as: case ... when it > 3 then [etc.].
The method is also aliased as "its", for methods that describe possessives
rather than actions, such as items.collect(&its.name.capitalize)

[This gem is an extension of Jay Philips' "methodphitamine" gem, updated
for ruby 1.9 and gemspec compatibility and adding the case statement functionality.]
}
  s.extra_rdoc_files = [
    "LICENSE.txt",
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', "~> 3.0"
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-gem-adapter'

end

