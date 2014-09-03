require 'spec_helper'

describe Admin::Ckeditor::BlogPostImagesController do

  let(:blog_post) { double("blog_post").as_null_object }
  let(:blog_post_id) { "100" }

  before :each do
    allow(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
  end

  let(:model) { blog_post }

  it_behaves_like "a controller for attaching images to models", {:blog_post_id => 100}

  describe "find_model" do
    it "calls unscoped find by with the blog post id" do
      expect(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
      get :index, :blog_post_id => blog_post_id
    end

    it "assigns to @model" do
      get :index, :blog_post_id => blog_post_id
      expect(assigns(:model)).to eq(blog_post)
    end
  end
end
