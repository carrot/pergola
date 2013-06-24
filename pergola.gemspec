# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pergola/version'

Gem::Specification.new do |spec|
  spec.name          = "pergola"
  spec.version       = Pergola::VERSION
  spec.authors       = ["adamjonas"]
  spec.email         = ["adam.jonas@carrotcreative.com"]
  spec.description   = %q{A ruby wrapper for the Vine API.}
  spec.summary       = %q{Tame the Vine API with pergola.}
  spec.homepage      = 'http://carrot.is/adamjonas'
  spec.license       = "MIT"

  spec.add_dependency "httparty", "~> 0.11.0"
  spec.add_dependency "hashie", "~> 2.0.5"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end