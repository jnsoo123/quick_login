$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quick_login/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quick_login"
  s.version     = QuickLogin::VERSION
  s.authors     = ["jnsoo123"]
  s.email       = ["neil.soo@adish.co.jp"]
  s.homepage    = ""
  s.summary     = "Summary of QuickLogin."
  s.description = "Description of QuickLogin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency "rails", ">= 5.0.0"
  s.add_dependency "devise", ">= 4.2.0"

  s.add_development_dependency "sqlite3"
end
