# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opml-handler/version'

Gem::Specification.new do |spec|
  spec.name          = "opml-handler"
  spec.version       = OpmlHandler::VERSION
  spec.authors       = ["hang"]
  spec.email         = ["iamchenhang@gmail.com"]

  spec.summary       = "handle opml file(support children nodes) for ruby application"
  spec.description   = "handle opml file(support children nodes) for ruby application, both export and import"
  spec.homepage      = "https://github.com/chenhang/opml-handler"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "nokogiri"
end
