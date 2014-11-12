require "simple_blog/engine"
require "shareable"

module SimpleBlog
  class Engine < ::Rails::Engine
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
