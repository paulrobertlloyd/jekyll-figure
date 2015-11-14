# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/figure/version'

Gem::Specification.new do |spec|
  spec.name        = "jekyll-figure"
  spec.version     = Jekyll::Figure::VERSION
  spec.summary     = "Jekyll plugin that generates <figure> elements."
  spec.description = "A liquid tag for Jekyll that generates <figure> elements."
  spec.authors     = ["Paul Robert Lloyd"]
  spec.email       = "me+rubygems@paulrobertlloyd.com"
  spec.files       = Dir.glob("lib/**/*.rb")
  spec.homepage    = "https://github.com/paulrobertlloyd/jekyll-figure"
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "jekyll", [">= 3.0", "< 4.0"]
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency "bundler", "~> 1.6"
end
