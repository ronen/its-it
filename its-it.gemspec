$:.push File.expand_path("../lib", __FILE__)
require 'its-it/version'

Gem::Specification.new do |s|
  s.name = 'its-it'
  s.version = ItsIt::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-04-23'
  s.authors = ['Ronen Barzel']
  s.email = 'ronen@barzel.org'
  s.homepage = 'http://github.com/ronen/its-it'
  s.summary = %q{Defines its() and it() method-chain proc proxies.}
  s.description = %q{
This gem defines the Kernel method "it", which extends the Symbol#to_proc
idiom to support chaining multiple methods.  For example,
items.collect(&it.to_s.capitalize).  The method is also aliased as "its",
for methods that describe possessives rather than actions, such as
items.collect(&its.name.capitalize)

[This gem is clone of Jay Philips' "methodphitamine" gem, updated for ruby 1.9 and gemspec compatibility.]
}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'blankslate'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'bueller'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-gem-adapter'

end

