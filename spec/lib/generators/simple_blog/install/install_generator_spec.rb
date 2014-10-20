require "generator_spec/test_case"
require "spec_helper"

require "generators/simple_blog/install/install_generator"

describe SimpleBlog::Generators::InstallGenerator do
  include GeneratorSpec::TestCase

  let(:generator) { SimpleBlog::Generators::InstallGenerator.new }

  before :each do
    allow(generator).to receive(:rake).with("simple_blog_engine:install:migrations")
    allow(generator).to receive(:rake).with("acts_as_taggable_on_engine:install:migrations")
  end

  describe "#install_public_javascript" do

    after :each do
      File.delete("app/assets/javascripts/application.js")
    end

    it "creates the file and appends 'simple_blog' when file not present" do
      generator.install_public_javascript
      assert_file "app/assets/javascripts/application.js", "\n//= require simple_blog\n"
    end

    it "appends 'simple_blog' to application.js when file is present" do
      FileUtils.mkdir_p("app/assets/javascripts/")
      File.open("app/assets/javascripts/application.js", "w")
      generator.install_public_javascript
      assert_file "app/assets/javascripts/application.js", "\n//= require simple_blog\n"
    end

  end

  describe "#install_admin_javascript" do

    after :each do
      File.delete("app/assets/javascripts/admin.js")
    end

    it "creates the file and appends 'simple_blog_admin' when file not present" do
      generator.install_admin_javascript
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog_admin\n"
    end

    it "appends 'simple_blog' to admin.js when file is present" do
      FileUtils.mkdir_p("app/assets/javascripts/")
      File.open("app/assets/javascripts/admin.js", "w")
      generator.install_admin_javascript
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog_admin\n"
    end

  end

  describe "#install_css_file" do

    after :each do
      File.delete("app/assets/stylesheets/application.css")
    end

    it "does not create application.css if not already present" do
      generator.install_css_file
      expected_text = %{\n *= require simple_blog_admin\n
*= require simple_blog_admin\n}
      assert_file "app/assets/stylesheets/application.css", expected_text
    end

    it "appends 'simple_blog_admin' to application.css when file is present" do
      FileUtils.mkdir_p("app/assets/stylesheets/")
      File.open("app/assets/stylesheets/application.css", "w")
      generator.install_css_file
      expected_text = %{\n *= require simple_blog_admin\n
*= require simple_blog_admin\n}
      assert_file "app/assets/stylesheets/application.css", expected_text
    end

  end

  describe "#run_migrations" do

    let(:generator) { SimpleBlog::Generators::InstallGenerator.new }
    
    before :each do
      allow(generator).to receive(:rake).with("simple_blog_engine:install:migrations")
      allow(generator).to receive(:rake).with("acts_as_taggable_on_engine:install:migrations")
    end

    it "runs the simple_blog_engine migrations" do
      expect(generator).to receive(:rake).with("simple_blog_engine:install:migrations")

      generator.run_migrations
    end

    it "runs the acts_as_taggable_on_engine migrations" do
      expect(generator).to receive(:rake).with("acts_as_taggable_on_engine:install:migrations")

      generator.run_migrations
    end

  end
end
