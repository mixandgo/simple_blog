require 'spec_helper'

describe BlogPostsController, :type => :controller do
  describe "#index" do
    let(:blog_post) { double("BlogPost") }

    before :each do
      allow(BlogPost).to receive(:all).and_return [blog_post]
    end

    it "finds all the blog posts" do
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
    let(:tag_name) { "cool tag" }
    let(:tag) { double("tag", :name => tag_name) }
    let(:blog_post) { double("BlogPost") }

    context "tag doesn't exist" do
      it "raises a RecordNotFound Error if the tag can't be found" do
        expect {
          get :filter, :tag => "invalid-tag"
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "tag exists" do
      before :each do
        allow(ActsAsTaggableOn::Tag).to receive(:find_by!).and_return(tag)
        allow(BlogPost).to receive(:tagged_with).with(tag, :on => :tags).and_return([blog_post])
      end

      it "finds all blog posts filtered by tag" do
        expect(BlogPost).to receive(:tagged_with).with(tag, :on => :tags)
        get :filter, :tag => tag_name
      end

      it "assigns to @blog_posts" do
        get :filter, :tag => tag_name
        expect(assigns(:blog_posts)).to eq([blog_post])
      end

      it "assigns to @page_title" do
        get :filter, :tag => "cool tag"
        expect(assigns(:page_title)).to eq("Cool Tag related posts")
      end

      it "renders the index template" do
        get :filter, :tag => tag_name
        expect(response).to render_template('blog_posts/index')
      end
    end

  end

  describe "#show" do
    let(:slug) { "cool slug" }
    let(:blog_post) { BlogPost.new }
    let(:blog_post_presenter) { BlogPostPresenter.new(blog_post) }

    context "valid slug" do
      before :each do
        allow(BlogPost).to receive(:unscoped_find_by!).with("slug" => slug).and_return blog_post
        allow(BlogPostPresenter).to receive(:new).with(blog_post).and_return blog_post_presenter
      end

      it "finds blog posts by slug" do
        expect(BlogPost).to receive(:unscoped_find_by!).with("slug" => slug)
        get :show, :slug => slug
      end

      it "assigns to @blog_post" do
        get :show, :slug => slug
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "assigns to @page_title" do
        get :show, :slug => slug
        expect(assigns(:page_title)).to eq(blog_post.title)
      end

      it "sets the blog post presenter"do
        expect(BlogPostPresenter).to receive(:new).with(blog_post)
        get :show, :slug => slug
      end

      it "assigns the @blog_post_presenter" do
        get :show, :slug => slug
        expect(assigns(:blog_post_presenter)).to eq(blog_post_presenter)
      end

      it "renders the show template" do
        get :show, :slug => slug
        expect(response).to render_template('blog_posts/show')
      end
    end

    it "renders a 404 if the post can't be found" do
      expect {
        get :show, :slug => "invalid-slug"
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
