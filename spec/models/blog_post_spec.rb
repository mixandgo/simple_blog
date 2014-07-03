require 'spec_helper'

describe BlogPost do

  describe "validations on update" do
    subject { create(:blog_post, :unpublished_empty) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should ensure_length_of(:title).is_at_most(72) }

    describe "uniqueness" do
      let(:title) { "unique title" }
      let!(:post) { create(:blog_post, :title => title) }

      it "should validate uniqueness of title" do
        expect(create(:blog_post, :title => title)).to have(1).errors_on(:title)
      end
    end

  end

  describe "validations on create" do
    subject { build(:blog_post, :unpublished_empty) }

    it { should_not validate_presence_of(:title) }
    it { should_not validate_uniqueness_of(:title) }
    it { should_not validate_presence_of(:description) }
    it { should_not validate_presence_of(:body) }
    it { should_not ensure_length_of(:title).is_at_most(72) }
  end

  describe "validations when published at date is present" do
    subject { create(:blog_post, :published_at => 1.week.ago, :description => "") }

    it { should validate_presence_of(:description) }
  end

  describe "before_save" do
    it "sets the slug" do
      post = create(:blog_post, :title => "Foo bar")
      expect(post.slug).to eq("foo-bar")
    end

    it "sets an empty slug for an empty post" do
      empty_post = create(:blog_post, :unpublished_empty)
      expect(empty_post.slug).to be_empty
    end
  end

  describe "default_scope" do
    it "finds all the published records" do
      published = create(:blog_post)
      create(:blog_post, :published_at => nil) # unpublished
      BlogPost.all.should == [published]
    end
  end

  describe "#published?" do
    it "returns true if published_at is not nil" do
      post = build(:blog_post)
      expect(post.published?).to be_true
    end

    it "returns false if published_at is nil" do
      post = build(:blog_post, :published_at => nil)
      expect(post.published?).to be_false
    end
  end

  describe "#to_param" do
    it "returns the name converted to a slug" do
      post = build(:blog_post, :title => "A cool title")
      expect(post.to_param).to eq("a-cool-title")
    end
  end

  describe "#pretty_title" do
    it "returns the title titleized" do
      post = build(:blog_post, :title => "a cool title")
      expect(post.pretty_title).to eq("A Cool Title")
    end
  end

  describe ".find_tags" do
    let(:term) { "term" }
    let(:blog_post) { double("blog_post") }
    let(:tag) { double("tag") }

    before :each do
      allow(BlogPost).to receive(:unscoped).and_return blog_post
    end

    it "searches for everything when term is empty string" do
      expect(blog_post).to receive(:all_tags).and_return [tag]
      BlogPost.find_tags("")
    end

    it "searches for the term" do
      expect(blog_post).to receive(:all_tags).with(:conditions => "tags.name LIKE 'term%'").and_return [tag]
      BlogPost.find_tags(term)
    end

  end

end
