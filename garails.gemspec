# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "garails/version"

Gem::Specification.new do |s|
  s.name        = "garails"
  s.version     = Garails::VERSION
  s.platform    = Gem::Platform::RUBY  
  s.authors     = 'Michael Reinsch', 'Paul McMahon'
  s.email       = "info@mobalean.com"
  s.homepage    = "http://github.com/mobalean/garails"
  s.description = "Google Analytics for Rails"
  s.summary     = "Google Analytics for Rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("gabbara", "~> 0.0.5")
end
