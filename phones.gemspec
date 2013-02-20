# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phones/version'

Gem::Specification.new do |gem|
  gem.name          = "phones"
  gem.version       = Phones::VERSION
  gem.authors       = ["Jarred Sumner"]
  gem.email         = ["jarred@jarredsumner.com"]
  gem.description   = %q{Phones is a barebones phone parsing and formatting library}
  gem.summary       = %q{Phones is a barebones phone parsing and formatting library}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

end
