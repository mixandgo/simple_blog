require 'spec_helper'
require 'blog_languages'

describe BlogLanguages, :type => :model do
  class BlogModel
    include BlogLanguages
  end

  before :each do
    @blog_model = BlogModel.new
  end

  describe "#languages_for_select" do

    it "returns a list containing arrays that have the language name and language translation" do
      expect(@blog_model.languages_for_select).to include(["English", "en"])
    end

  end

  describe "#language_full_name" do

    it "returns the language translation from the language code" do
      expect(@blog_model.language_full_name("en")).to eq("English")
    end

  end


end
