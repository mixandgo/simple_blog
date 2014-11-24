module SimpleBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Integrate SimpleBlog with your application"
      source_root File.expand_path("../templates", __FILE__)

      def install_public_javascript
        folder = "app/assets/javascripts"
        file = "application.js"

        text = <<JS_FILES
//= require simple_blog\n
JS_FILES
        install_libraries(folder, file, text)
      end

      def install_admin_javascript
        folder = "app/assets/javascripts"
        file = "admin.js"

        text = "\n//= require simple_blog_admin\n"
        install_libraries(folder, file, text)
      end

      def install_css_file
        folder = "app/assets/stylesheets"
        file = "application.css"

        text = <<CSS_FILES
*= require simple_blog\n
CSS_FILES
        install_libraries(folder, file, text)
      end

      def install_admin_css_file
        folder = "app/assets/stylesheets/admin"
        file = "admin.css"

        text = <<CSS_FILES
*= require simple_blog_admin\n
CSS_FILES
        install_libraries(folder, file, text)
      end

      def create_initializer
        copy_file "initializer.rb", "config/initializers/simple_blog.rb"
      end


      def run_migrations
        rake "simple_blog_engine:install:migrations"
        rake "acts_as_taggable_on_engine:install:migrations"
      end

      private

      def install_libraries(folder, file, text)
        inside folder do
          File.open(file, "w") unless File.exists?(file)

          append_to_file file do
            text
          end

        end
      end
    end
  end
end
