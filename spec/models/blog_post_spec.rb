require 'spec_helper'

describe BlogPost do

  subject { build(:blog_post) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:title).is_at_most(72) }

  describe "if unpublished" do
    subject { build(:blog_post, :empty_post) }

    it { should_not validate_presence_of(:title) }
    it { should_not validate_uniqueness_of(:title) }
    it { should_not validate_presence_of(:description) }
    it { should_not validate_presence_of(:body) }
    it { should_not ensure_length_of(:title).is_at_most(72) }
  end

  describe "uniquenss" do
    let(:title) { "unique title" }
    let!(:post) { create(:blog_post, :title => title) }

    it "should validate uniqueness of title" do
      expect(build(:blog_post, :title => title)).to have(1).errors_on(:title)
    end
  end

  describe "before_save" do
    it "sets the slug" do
      post = build(:blog_post, :title => "Foo bar")
      post.save
      expect(post.slug).to eq("foo-bar")
    end

    it "sets a random title" do
      post = build(:blog_post, :empty_post)
      post.save
      expect(post.title).to_not be_nil
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

  describe "#safe_body" do
    let(:safe_body_text) { "safe body" }

    it "returns the html safe body" do
      blog_post = build(:blog_post)

      expect(blog_post.body).to receive(:html_safe).and_return safe_body_text
      expect(blog_post.safe_body).to eq(safe_body_text)
    end

    it "returns an empty string when body is nil" do
      empty_blog_post = build(:blog_post, :empty_post)

      expect(empty_blog_post.safe_body).to eq("")
    end
  end

  describe "#safe_description" do
    let(:safe_description_text) { "safe description" }

    it "returns the html safe description" do
      blog_post = build(:blog_post)

      expect(blog_post.description).to receive(:html_safe).and_return safe_description_text
      expect(blog_post.safe_description).to eq(safe_description_text)
    end

    it "returns an empty string when description is nil" do
      empty_blog_post = build(:blog_post, :empty_post)

      expect(empty_blog_post.safe_description).to eq("")
    end
  end

end
