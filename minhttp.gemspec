# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minhttp/version'

Gem::Specification.new do |spec|
  spec.name          = "minhttp"
  spec.version       = MinHTTP::VERSION
  spec.authors       = ["Nathaniel Talbott", "Adam Williams"]
  spec.email         = ["nathaniel@spreedly.com", "adam@spreedly.com"]
  spec.summary       = %q{A minimal HTTP request library.}
  spec.description   = %q{A minimal HTTP request library. Tries to bring sanity to the net/http API.}
  spec.homepage      = "https://github.com/spreedly/minhttp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
