require 'spec_helper'

describe BlogPost, :type => :model do

  describe "validations on update" do
    subject { BlogPost.create }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to ensure_length_of(:title).is_at_most(72) }

    describe "uniqueness" do
      let(:title) { "unique title" }
      let!(:post) { create(:blog_post, :title => title) }
      let!(:duplicated_blog_post) { build(:blog_post) }

      it "should validate uniqueness of title" do
        duplicated_blog_post.update(:title => title)
        duplicated_blog_post.valid?
        expect(duplicated_blog_post.errors[:title].size).to eq(1)
      end
    end
  end

  describe "validations on create" do
    subject { BlogPost.new }

    it { is_expected.not_to validate_presence_of(:title) }
    it { is_expected.not_to validate_uniqueness_of(:title) }
    it { is_expected.not_to validate_presence_of(:description) }
    it { is_expected.not_to validate_presence_of(:body) }
    it { is_expected.not_to ensure_length_of(:title).is_at_most(72) }
  end

  describe "validations when published at date is present" do
    subject { create(:blog_post, :published_at => 1.week.ago, :description => "") }

    it { is_expected.to validate_presence_of(:description) }
  end

  describe "before_save" do
    it "sets the slug" do
      post = create(:blog_post, :title => "Foo bar")
      expect(post.slug).to eq("foo-bar")
    end

    it "sets an empty slug for an empty post" do
      empty_post = BlogPost.create
      expect(empty_post.slug).to be_nil
    end
  end

  describe "default_scope" do
    it "finds all the published records" do
      published = create(:blog_post)
      create(:blog_post, :published_at => nil) # unpublished
      expect(BlogPost.all).to eq([published])
    end
  end

  describe "#published?" do
    it "returns true if published_at is not nil" do
      post = build(:blog_post)
      expect(post.published?).to be(true)
    end

    it "returns false if published_at is nil" do
      post = build(:blog_post, :published_at => nil)
      expect(post.published?).to be(false)


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
    let(:blog_post) { class_double("BlogPost") }
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

  describe "#find_image_by" do
    let(:images) { double("images").as_null_object }
    let(:blog_post) { BlogPost.new }
    let(:id) { "100" }

    before :each do
      allow(blog_post).to receive(:images).and_return images
      allow(images).to receive(:where).with(id).and_return images
    end

    it "looks for image with specified id" do
      expect(images).to receive(:where).with(id)
      blog_post.find_image_by(id)
    end

    it "returns the first image from the list of returned images" do
      expect(images).to receive(:first)
      blog_post.find_image_by(id)
    end
  end
end
