require 'jquery-rails'
require 'ckeditor_rails'

module SimpleBlog
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
