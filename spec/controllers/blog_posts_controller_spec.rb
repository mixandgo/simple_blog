require 'spec_helper'

describe BlogPostsController, :type => :controller do
  describe "#index" do
    let(:blog_post) { double("BlogPost") }

    before :each do
      allow(BlogPost).to receive(:all).and_return [blog_post]
    end

    it "returns all the blog posts" do
      expect(BlogPost).to receive(:all)
      get :index
    end

    it "assigns to @blog_posts" do
      get :index
      expect(assigns(:blog_posts)).to eq([blog_post])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('blog_posts/index')
    end
  end

  describe "#filter" do
    let(:tag) { "cool tag" }
    let(:blog_post) { double("BlogPost") }

    before :each do
      allow(BlogPost).to receive(:tagged_with).with(tag).and_return [blog_post]
    end

    it "returns all blog posts filtered by tag" do
      expect(BlogPost).to receive(:tagged_with).with(tag)
      get :filter, :tag => tag
    end

    it "assigns to @blog_posts" do
      get :filter, :tag => tag
      expect(assigns(:blog_posts)).to eq([blog_post])
    end

    it "renders the index template" do
      get :filter, :tag => tag
      expect(response).to render_template('blog_posts/index')
    end

  end

  describe "#show" do
    let(:slug) { "cool slug" }
    let(:blog_post) { double("BlogPost") }

    it "returns blog posts by slug" do
      expect(BlogPost).to receive(:find_by!).with("slug" => slug)
      get :show, :slug => slug
    end

    it "assigns to @blog_post" do
      allow(BlogPost).to receive(:find_by!).with("slug" => slug).and_return blog_post
      get :show, :slug => slug
      expect(assigns(:blog_post)).to eq(blog_post)
    end

    it "renders the show template" do
      expect(BlogPost).to receive(:find_by!).with("slug" => slug)
      get :show, :slug => slug
      expect(response).to render_template('blog_posts/show')
    end

    it "renders a 404 if the post can't be found" do
      expect {
        get :show, :slug => "invalid-slug"
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
