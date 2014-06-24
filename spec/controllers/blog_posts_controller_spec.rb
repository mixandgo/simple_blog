require 'spec_helper'

describe BlogPostsController do
  describe "#index" do
    it "should assign all blog_posts" do
      BlogPost.should_receive(:all)
      get :index
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('blog_posts/index')
    end
  end

  describe "#filter" do
    let(:tag) { "cool tag" }

    it "assigns tagged posts to @blog_posts" do
      BlogPost.should_receive(:tagged_with).with(tag)
      get :filter, :tag => tag
    end

    it "renders the index template" do
      get :filter, :tag => tag
      expect(response).to render_template('blog_posts/index')
    end

  end

  describe "#show" do
    let(:slug) { "cool slug" }

    it "assigns @blog_post" do
      BlogPost.should_receive(:find_by!).with("slug" => slug)
      get :show, :slug => slug
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
