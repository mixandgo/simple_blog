require "generator_spec/test_case"
require "spec_helper"

require "generators/simple_blog/install/install_generator"

describe SimpleBlog::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../../../../tmp", __FILE__)

  before :each do
    prepare_destination
  end

  after :each do
    FileUtils.rm_rf("spec/tmp")
  end

  describe "#install_public_javascript" do

    it "creates the file and appends 'simple_blog' when file not present" do
      run_generator
      assert_file "app/assets/javascripts/application.js", "\n//= require simple_blog\n"
    end

    it "appends 'simple_blog' to application.js when file is present" do
      FileUtils.mkdir_p("spec/tmp/app/assets/javascripts/")
      File.open("spec/tmp/app/assets/javascripts/application.js", "w")
      run_generator
      assert_file "app/assets/javascripts/application.js", "\n//= require simple_blog\n"
    end

  end

  describe "#install_admin_javascript" do

    it "creates the file and appends 'simple_blog' when file not present" do
      run_generator
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog\n"
    end

    it "appends 'simple_blog' to admin.js when file is present" do
      FileUtils.mkdir_p("spec/tmp/app/assets/javascripts/")
      File.open("spec/tmp/app/assets/javascripts/admin.js", "w")
      run_generator
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog\n"
    end

  end

  describe "#install_css_file" do

    it "does not create application.css if not already present" do
      run_generator
      assert_file "app/assets/stylesheets/application.css", "\n * require simple_blog\n"
    end

    it "appends 'simple_blog' to application.css when file is present" do
      FileUtils.mkdir_p("spec/tmp/app/assets/stylesheets/")
      File.open("spec/tmp/app/assets/stylesheets/application.css", "w")
      run_generator
      assert_file "app/assets/stylesheets/application.css", "\n * require simple_blog\n"
    end

  end

  describe "#install_migrations" do
    before :each do
      FileUtils.mkdir_p("spec/tmp/db/migrate")
    end

    it "makes a copy of the migration" do
      run_generator
      assert_migration "db/migrate/create_blog_posts.rb"
    end

    it "does not make another copy if migration exists" do
      File.open("spec/tmp/db/migrate/123_create_blog_posts.rb", "w")
      run_generator
      File.delete("spec/tmp/db/migrate/123_create_blog_posts.rb")
      assert_no_migration "db/migrate/create_blog_posts.rb"
    end
  end

end
