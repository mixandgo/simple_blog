require 'spec_helper'

describe BlogPostsController do
  describe "#index" do
    let(:post) { double("post") }

    it "should assign all blog_posts" do
      expect(BlogPost).to receive(:all).and_return [post]
      get :index
      expect(assigns(:blog_posts)).to eq([post])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('blog_posts/index')
    end
  end

  describe "#filter" do
    let(:tag) { "cool tag" }
    let(:post) { double("post") }

    it "assigns tagged posts to @blog_posts" do
      expect(BlogPost).to receive(:tagged_with).with(tag).and_return [post]
      get :filter, :tag => tag
      expect(assigns(:blog_posts)).to eq([post])
    end

    it "renders the index template" do
      get :filter, :tag => tag
      expect(response).to render_template('blog_posts/index')
    end

  end

  describe "#show" do
    let(:slug) { "cool slug" }
    let(:post) { double("post") }

    it "assigns @blog_post" do
      expect(BlogPost).to receive(:find_by!).with("slug" => slug).and_return post

      get :show, :slug => slug
      expect(assigns(:blog_post)).to eq(post)
    end

    it "renders the show template" do
      BlogPost.should_receive(:find_by!).with("slug" => slug)
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
