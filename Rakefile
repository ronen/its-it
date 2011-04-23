require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
require './lib/its-it/version'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "its-it"
  gem.homepage = "http://github.com/ronen/its-it"
  gem.license = "MIT"
  gem.summary = %Q{Defines its() and it() method-chain proc proxies.}
  gem.description = %Q{
This gem defines the Kernel method "it", which extends the Symbol#to_proc
idiom to support chaining multiple methods.  For example,
items.collect(&it.to_s.capitalize).  The method is also aliased as "its",
for methods that describe possessives rather than actions, such as
items.collect(&its.name.capitalize)

[This gem is clone of Jay Philips' "methodphitamine" gem, updated for ruby 1.9 and gemspec compatibility.]
}
  gem.email = "ronen@barzel.org"
  gem.authors = ["Ronen Barzel"]
  gem.version = ItsIt::Version::STRING
  gem.add_runtime_dependency 'blankslate'
  gem.add_development_dependency "rspec", "~> 2.3.0"
  gem.add_development_dependency "bundler", "~> 1.0.0"
  gem.add_development_dependency "jeweler", "~> 1.5.2"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "simplecov-gem-adapter"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "its-it #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
