require 'spec_helper'

describe BlogPost do
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
  it { should ensure_length_of(:title).is_at_most(72) }

  describe "before_save" do
    it "sets the slug" do
      post = FactoryGirl.build(:blog_post, :title => "Foo bar")
      post.save
      expect(post.slug).to eq("foo-bar")
    end
  end

  describe "default_scope" do
    it "finds all the published records" do
      published = FactoryGirl.create(:blog_post)
      FactoryGirl.create(:blog_post, :published_at => nil) # unpublished
      BlogPost.all.should == [published]
    end
  end

  describe "#published?" do
    it "returns true if published_at is not nil" do
      post = FactoryGirl.build(:blog_post)
      expect(post.published?).to be_true
    end

    it "returns false if published_at is nil" do
      post = FactoryGirl.build(:blog_post, :published_at => nil)
      expect(post.published?).to be_false
    end
  end

  describe "#to_param" do
    it "returns the name converted to a slug" do
      post = FactoryGirl.build(:blog_post, :title => "A cool title")
      expect(post.to_param).to eq("a-cool-title")
    end
  end

  describe ".find_blog_post!" do
    it "returns the blog post by slug" do
      blog_post = create(:blog_post, :title => "A cool title")
      expect(BlogPost.find_blog_post!("a-cool-title")).to eq(blog_post)
    end

    it "raises a 404 if post can't be found" do
      expect {
        BlogPost.find_blog_post!("some_slug")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
