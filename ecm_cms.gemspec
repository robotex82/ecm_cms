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

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "active_admin-awesome_nested_set"
  s.add_dependency "awesome_nested_set"
  s.add_dependency "draper"
  s.add_dependency "i18n_routing"
  s.add_dependency "RedCloth"
  s.add_dependency "simple-navigation"
  s.add_dependency "simple-navigation-bootstrap"

  # Development Database
  s.add_development_dependency "sqlite3"

  # Development Server
  s.add_development_dependency "thin"

  # Documentation
  s.add_development_dependency "yard"

  # Dummy app
  # s.add_development_dependency 'activeadmin'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'less-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'therubyracer'
  s.add_development_dependency "twitter-bootstrap-rails"

  # Tests
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails', '~> 1.0'

  # Test automation
  s.add_development_dependency 'rb-inotify', '~> 0.9'
  # See gemfile for a patched version, for engine support.
  # s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
end

