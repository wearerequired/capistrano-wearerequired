lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano/required_tools/version'

Gem::Specification.new do |spec|
  spec.name        = "capistrano-required_tools"
  spec.version     = Capistrano::RequiredTools::VERSION
  spec.summary     = %q{Tools for Capistrano used by required.}
  spec.authors     = ["required"]
  spec.email       = "info@required.ch"
  spec.homepage    = "https://required.com"
  spec.license     = "GPL-2.0+"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.6"
  spec.add_dependency "slackistrano", "~> 3.1"
  spec.add_dependency "capistrano-composer", "~> 0.0.6"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 11.0"
end
