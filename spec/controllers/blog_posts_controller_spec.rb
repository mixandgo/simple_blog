require 'spec_helper'

describe BlogPostsController do
  describe "#index" do
    it "assigns published posts to @blog_posts" do
      post = FactoryGirl.create(:blog_post)
      FactoryGirl.create(:blog_post, :published_at => nil)
      get :index
      expect(assigns(:blog_posts)).to eq([post])
    end

    it "returns posts tagged with specified tag" do
      BlogPost.should_receive(:tagged_with)
      get :index, :tag => "tag"
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('blog_posts/index')
    end
  end

  describe "#show" do
    let(:post) { FactoryGirl.create(:blog_post) }

    it "assigns @blog_post" do
      get :show, :slug => post.slug
      expect(assigns(:blog_post)).to eq(post)
    end

    it "renders the show template" do
      get :show, :slug => post.slug
      expect(response).to render_template('blog_posts/show')
    end

    it "renders a 404 if the post can't be found" do
      expect {
        get :show, :slug => "invalid-slug"
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
