# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_new/version'

Gem::Specification.new do |s|
  s.name          = 'rails_new'
  s.version       = RailsNew::VERSION
  s.authors       = ['Lucas Caton']
  s.email         = ['lucascaton@gmail.com']
  s.description   = %q{Bootstrap for Rails projects - Customizable Rails template with Twitter Bootstrap, Devise and more!}
  s.summary       = %q{Bootstrap for Rails projects - Customizable Rails template with Twitter Bootstrap, Devise and more!}
  s.homepage      = 'https://github.com/lucascaton/rails_new'
  s.license       = 'MIT'

  s.add_dependency 'rails', '4.0.1'
  s.add_development_dependency 'rspec'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.require_paths = ['lib']
end
