$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_blog"
  s.version     = SimpleBlog::VERSION
  s.authors     = ["Halmagean Cezar"]
  s.email       = ["cezar@halmagean.ro"]
  s.homepage    = "http://cezar.halmagean.ro"
  s.summary     = "Simple rails engine that you can plug into your app"
  s.description = "I needed a blog engine that I could use for every new site I'm building so I've decided to build my own."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "jquery-rails"
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'redcarpet'
  s.add_dependency 'rouge'
  s.add_dependency "social-share-button"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "launchy"
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "database_cleaner"
end
