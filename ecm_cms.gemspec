$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_cms"
  s.version     = Ecm::Cms::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/ecm_cms"
  s.summary     = "CMS Module for active admin."
  s.description = "CMS Module for active admin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"

  # Development Server
  s.add_development_dependency "thin"

  # Documentation
  s.add_development_dependency "yard"

  # Active admin
  s.add_development_dependency 'activeadmin'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'coffee-rails'

  # Tests
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails', '~> 1.0'

  # Fake Data Generation
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'forgery'

  # Test automation
  s.add_development_dependency 'rb-inotify', '~> 0.8.8'
  # s.add_development_dependency 'guard-rails' # See gemfile for a patched version, for engine support.
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
end

