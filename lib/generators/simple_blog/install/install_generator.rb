module SimpleBlog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Integrate SimpleBlog with your application"
      source_root File.expand_path('../templates', __FILE__)

      def install_public_javascript
        js_path = "app/assets/javascripts/application.js"
        original_js = File.binread(js_path) if File.exists?(js_path)

        if original_js.include?("simple_blog")
          say_status("skipped", "insert into #{js_path}", :yellow)
        else
          append_to_file js_path do
            "\n//= require simple_blog\n"
          end
        end
      end

      def install_admin_javascript
        js_path = "app/assets/javascripts/admin.js"
        if File.exists?(js_path)
          original_js = File.binread(js_path)

          if original_js.include?("simple_blog_admin")
            say_status("skipped", "insert into #{js_path}", :yellow)
          else
            append_to_file js_path do
              "\n//= require simple_blog_admin\n"
            end
          end
        end
      end

      def install_public_stylesheets
        # if it's a css file
        css_path = "app/assets/stylesheets/application.css"
        if File.exists?(css_path)
          original_css = File.binread(css_path)
          # if it's a sass file
          css_path = "app/assets/stylesheets/application.scss"
          if File.exists?(css_path)
            original_scss = File.binread(css_path)

            if original_css
              if original_css.include?("simple_blog")
                say_status("skipped", "insert into #{css_path}", :yellow)
              else
                insert_into_file css_path, :before => "*/" do
                  "\n * require simple_blog\n"
                end
              end
            elsif original_scss
              if original_scss.include?("simple_blog")
                say_status("skipped", "insert into #{css_path}", :yellow)
              else
                append_to_file css_path do
                  "\n@import \"simple_blog\";\n"
                end
              end
            end
          end
        end
      end
    end
  end
end
