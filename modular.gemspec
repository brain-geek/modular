# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'modular/version'

Gem::Specification.new do |s|
  s.name        = "modular"
  s.version     = Modular::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Rozumiy"]
  s.email       = ["brain-geek@yandex.ua"]
  s.homepage    = "https://github.com/brain-geek/modular"
  s.summary     = %q{This gem provides functionality for modular frontend layout}
  s.description = %q{This gem provides functionality for modular frontend layout}

  s.rubyforge_project = "modular"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "rails"
  s.add_development_dependency "rspec", ">= 2.0.0"
end
