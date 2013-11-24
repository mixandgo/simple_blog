require 'spec_helper'

describe BlogPost do
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
  it { should ensure_length_of(:title).is_at_most(72) }
  it { should have_many(:blog_tags) }

  describe "before_save" do
    it "sets the slug" do
      post = FactoryGirl.build(:blog_post, :title => "Foo bar")
      post.save
      expect(post.slug).to eq("foo-bar")
    end
  end

  describe ".published" do
    it "finds all the published records" do
      published = FactoryGirl.create(:blog_post)
      FactoryGirl.create(:blog_post, :published_at => nil) # unpublished
      BlogPost.published.should == [published]
    end
  end

  describe "#to_param" do
    it "returns the name converted to a slug" do
      post = FactoryGirl.build(:blog_post, :title => "A cool title")
      expect(post.to_param).to eq("a-cool-title")
    end
  end
end
