require "generator_spec/test_case"
require "spec_helper"

require "generators/simple_blog/install/install_generator"

describe SimpleBlog::Generators::InstallGenerator do
  include GeneratorSpec::TestCase

  describe "#create_initializer" do
    let(:generator) { SimpleBlog::Generators::InstallGenerator.new }

    it "creates a initializer file with the default info" do
      expect(generator).to receive(:copy_file).with("initializer.rb", "config/initializers/simple_blog.rb")

      generator.create_initializer
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
