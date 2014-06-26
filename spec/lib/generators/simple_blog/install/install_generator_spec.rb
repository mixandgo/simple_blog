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

    it "creates the file and appends 'simple_blog_admin' when file not present" do
      run_generator
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog_admin\n"
    end

    it "appends 'simple_blog' to admin.js when file is present" do
      FileUtils.mkdir_p("spec/tmp/app/assets/javascripts/")
      File.open("spec/tmp/app/assets/javascripts/admin.js", "w")
      run_generator
      assert_file "app/assets/javascripts/admin.js", "\n//= require simple_blog_admin\n"
    end

  end
end
