# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hermit/version'

Gem::Specification.new do |spec|
  spec.name          = "hermit"
  spec.version       = Hermit::VERSION
  spec.authors       = ["Chizzy"]
  spec.email         = ["emailMe@chizzys.com"]
  spec.summary       = "The Hermit"
  spec.description   = "The Hermit Gem"
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "sidekiq"
  spec.add_runtime_dependency "sidekiq-limit_fetch"
  spec.add_runtime_dependency "selenium-webdriver"
  spec.add_runtime_dependency "jsonable"
  spec.add_runtime_dependency "nokogiri"
end
