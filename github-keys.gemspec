# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github/keys/version'

Gem::Specification.new do |gem|
  gem.name          = "github-keys"
  gem.version       = Github::Keys::VERSION
  gem.authors       = ["Sho Kusano"]
  gem.email         = ["rosylilly@aduca.org"]
  gem.description   = %q{easy get github keys}
  gem.summary       = %q{easy get github keys}
  gem.homepage      = "https://github.com/rosylilly/github-keys"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_dependency 'slop', '~> 3.4.3'
  gem.add_dependency 'github_api', '~> 0.8.11'
end
