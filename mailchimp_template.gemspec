# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailchimp_template/version'

Gem::Specification.new do |spec|
  spec.name          = "mailchimp_template"
  spec.version       = MailchimpTemplate::VERSION
  spec.authors       = ["Steven Karas"]
  spec.email         = ["steven.karas@gmail.com"]
  spec.summary       = %q{Implementation of Mailchimp Template Language}
  spec.description   = %q{Implementaiton of Mailchimp Template Language. Not all features are supported, but most are}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"
end
