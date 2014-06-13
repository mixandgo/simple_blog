require 'jquery-rails'
require 'ckeditor_rails'

module SimpleBlog
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    initializer "simple_blog.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin.js)
    end

    isolate_namespace SimpleBlog

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

  end
end
