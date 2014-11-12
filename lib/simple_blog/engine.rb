require 'jquery-rails'
require 'carrierwave'
require 'social-share-button'
require 'mini_magick'
require 'acts-as-taggable-on'

module SimpleBlog

  mattr_accessor :twitter_site_name, :fb_app_id
  self.twitter_site_name = ""
  self.fb_app_id = ""

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
