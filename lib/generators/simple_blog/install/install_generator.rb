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

        text = "\n//= require simple_blog_admin\n"
        install_libraries(folder, file, text)
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
