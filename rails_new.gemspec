# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_new/version'

Gem::Specification.new do |gem|
  gem.name          = 'rails_new'
  gem.version       = RailsNew::VERSION
  gem.authors       = ['Lucas Caton']
  gem.email         = ['lucascaton@gmail.com']
  gem.description   = %q{Customizable Rails template with Twitter Bootstrap, Devise and more!}
  gem.summary       = %q{Customizable Rails template with Twitter Bootstrap, Devise and more!}
  gem.homepage      = 'https://github.com/lucascaton/rails_new'

  gem.add_dependency 'rails', '3.2.9'
  # gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ['lib']
end
