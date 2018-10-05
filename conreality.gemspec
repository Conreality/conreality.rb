#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'conreality'
  gem.homepage           = 'https://sdk.conreality.org/ruby/'
  gem.license            = 'Unlicense'
  gem.summary            = 'Conreality Software Development Kit (SDK) for Ruby.'
  gem.description        = gem.summary

  gem.author             = 'Conreality.org'
  gem.email              = 'conreality@googlegroups.com'

  gem.metadata = {
    'bug_tracker_uri'   => 'https://github.com/conreality/conreality.rb/issues',
    'changelog_uri'     => 'https://github.com/conreality/conreality.rb/blob/master/CHANGES.rst',
    'documentation_uri' => 'https://www.rubydoc.info/github/conreality/conreality.rb/master',
    'homepage_uri'      => gem.homepage,
    'mailing_list_uri'  => 'https://groups.google.com/forum/#!forum/conreality',
    'source_code_uri'   => 'https://github.com/conreality/conreality.rb',
    'wiki_uri'          => 'https://wiki.conreality.org/Ruby',
  }

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CREDITS.rst README UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
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
  gem.add_runtime_dependency     'grpc',  '~> 1.15'
  gem.add_runtime_dependency     'uuid',  '~> 2.3', '>= 2.3.9'
  gem.post_install_message       = nil
end
