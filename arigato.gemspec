# -*- encoding: utf-8 -*-

require File.expand_path('../lib/arigato/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "arigato"
  gem.version       = Arigato::VERSION
  gem.summary       = 'Special Thanks Page Generator'
  gem.description   = 'Generate HTML or JSON, YAML, CSV form your Gemfile' 
  gem.license       = "MIT"
  gem.authors       = ["tnantoka"]
  gem.email         = "bornneet@livedoor.com"
  gem.homepage      = "https://github.com/tnantoka/arigato#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
  gem.add_development_dependency 'simplecov'

  gem.add_dependency 'thor', '0.17.0'
  gem.add_dependency 'bundler', '1.3.4'
end