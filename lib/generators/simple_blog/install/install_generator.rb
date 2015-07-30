module SimpleBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Integrate SimpleBlog with your application"
      source_root File.expand_path("../templates", __FILE__)

      def create_initializer
        copy_file "initializer.rb", "config/initializers/simple_blog.rb"
      end

      def run_migrations
        rake "simple_blog_engine:install:migrations"
        rake "acts_as_taggable_on_engine:install:migrations"
      end
    end
  end
end
