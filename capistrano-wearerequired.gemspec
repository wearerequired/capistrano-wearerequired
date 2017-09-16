lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano/wearerequired/version'

Gem::Specification.new do |spec|
  spec.name        = "capistrano-wearerequired"
  spec.version     = Capistrano::Wearerequired::VERSION
  spec.description = "Capistrano::Wearerequired is a collection of recipes and tasks specialized on WordPress deployment."
  spec.summary     = "Recipes for Capistrano used by required gmbh"
  spec.authors     = ["wearerequired", "Pascal Birchler", "Ulrich Pogson", "Dominik Schilling"]
  spec.email       = "info@required.ch"
  spec.homepage    = "https://github.com/wearerequired/capistrano-wearerequired"
  spec.license     = "GPL-2.0+"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0"
  spec.add_dependency "capistrano", "~> 3.6"
  spec.add_dependency "slackistrano", "~> 3.1"
  spec.add_dependency "capistrano-composer", "~> 0.0.6"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 11.0"
end
