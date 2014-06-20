module SimpleBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Integrate SimpleBlog with your application"
      source_root File.expand_path("../templates", __FILE__)

      def install_public_javascript
        folder = "app/assets/javascripts"
        file = "application.js"

        text = "\n//= require simple_blog\n"
        install_libraries(folder, file, text)
      end

      def install_admin_javascript
        folder = "app/assets/javascripts"
        file = "admin.js"

        text = "\n//= require simple_blog\n"
        install_libraries(folder, file, text)
      end

      def install_css_file
        folder = "app/assets/stylesheets"
        file = "application.css"

        text = "\n * require simple_blog\n"
        install_libraries(folder, file, text)
      end

      def install_migrations
        copy_migration "create_blog_posts.rb"
      end

      private

      def copy_migration(file)
        copy_file file, "db/migrate/#{migration_number}_#{file}" unless migration_exists?(file)
      end

      def migration_exists?(file)
        file_exists = false
        inside "db/migrate/" do
          exists_exists = Dir.glob("*.rb").each do |existing_file|
            return true if existing_file =~ Regexp.new(file)
          end
        end
        file_exists
      end

      def migration_number
        Time.now.utc.strftime("%Y%m%d%H%M%S").to_s
      end

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
