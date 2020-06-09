$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spina/upgrade/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina-upgrade"
  s.version     = Spina::Upgrade::VERSION
  s.authors     = ["Bram Jetten"]
  s.email       = ["bram@denkgroot.com"]
  s.homepage    = "https://www.spinacms.com"
  s.summary     = "Upgrade Spina to 2.0"
  s.description = "Upgrade Spina to 2.0 from a previous version"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "> 5.2.0"
  s.add_dependency "carrierwave"
  s.add_dependency "ruby-progressbar"
end
