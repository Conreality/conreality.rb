#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'conreality'
  gem.homepage           = 'https://github.com/conreality/conreality.rb'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'Conreality Software Development Kit (SDK) for Ruby.'
  gem.description        = gem.summary

  gem.author             = 'Conreality.org'
  gem.email              = 'conreality@googlegroups.com'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CREDITS.rst README.md UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()

  gem.required_ruby_version      = '>= 2.5.1'         # Ubuntu 18.04 LTS
  gem.required_rubygems_version  = '>= 2.7.6'         # Ruby 2.5.1
  gem.requirements               = []
  gem.add_development_dependency 'rake',  '>= 12.3.1' # Ruby 2.5.1
  gem.add_development_dependency 'rspec', '>= 3.8'
  gem.add_development_dependency 'yard' , '>= 0.9'
  gem.post_install_message       = nil
end
