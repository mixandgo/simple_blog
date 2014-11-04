require 'jquery-rails'
require 'carrierwave'
require 'social-share-button'
require 'mini_magick'
require 'acts-as-taggable-on'

module SimpleBlog

  class << self
    mattr_accessor :website_name, :fb_app_id
    self.website_name = "Simple Blog"
    self.fb_app_id = "123"
  end

  def self.setup(&block)
    yield self
  end

  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    initializer "simple_blog.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin.js)
    end

  end
end
