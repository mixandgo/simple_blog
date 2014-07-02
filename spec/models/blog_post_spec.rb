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
      post = create(:blog_post, :title => "Foo bar")
      expect(post.slug).to eq("foo-bar")
    end

    it "sets an empty slug for an empty post" do
      empty_post = create(:blog_post, :empty_post)
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

    it "returns the default title when title empty" do
      post = build(:blog_post, :title => "")
      expect(post.pretty_title).to eq("Empty title")
    end
  end

  describe "#safe_body" do
    let(:safe_body_text) { "safe body" }
    let(:blog_post) { build(:blog_post) }


    it "returns the html safe body" do
      expect(blog_post.body).to receive(:html_safe).and_return safe_body_text

      expect(blog_post.safe_body).to eq(safe_body_text)
    end
  end

  describe "#safe_description" do
    let(:safe_description_text) { "safe description" }
    let(:blog_post) { build(:blog_post) }

    it "returns the html safe description" do
      expect(blog_post.description).to receive(:html_safe).and_return safe_description_text

      expect(blog_post.safe_description).to eq(safe_description_text)
    end
  end

  describe "#default_values" do
    let(:blog_post) { BlogPost.create }

    it "sets the body to an empty string" do
      expect(blog_post.body).to be_a(String)
      expect(blog_post.body).to be_empty
    end

    it "sets the description to an empty string" do
      expect(blog_post.description).to be_a(String)
      expect(blog_post.description).to be_empty
    end

    it "sets the title to an empty string" do
      expect(blog_post.title).to be_a(String)
      expect(blog_post.title).to be_empty
    end

  end

end
