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
  gem.files              = %w(AUTHORS CREDITS README UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 2.2'
  gem.required_rubygems_version  = '>= 2.4.5'
  gem.requirements               = []
  gem.add_development_dependency 'rake',  '>= 12'
  gem.add_development_dependency 'rspec', '>= 3.6'
  gem.add_development_dependency 'yard' , '>= 0.9'
  gem.post_install_message       = nil
end
