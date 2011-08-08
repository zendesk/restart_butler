# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "restart_butler/version"

Gem::Specification.new do |s|
  s.name        = "restart_butler"
  s.version     = RestartButler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michal bugno"]
  s.email       = ["michal@futuresimple.com"]
  s.homepage    = ""
  s.summary     = %q{script/restart helper}
  s.description = %q{Provides simpler way to restart apps}

  s.rubyforge_project = "restart_butler"

  s.add_dependency "logger"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
