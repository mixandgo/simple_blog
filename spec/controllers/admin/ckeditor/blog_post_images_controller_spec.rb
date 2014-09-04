require 'spec_helper'

describe Admin::Ckeditor::BlogPostImagesController do

  let(:blog_post) { double("blog_post").as_null_object }
  let(:blog_post_id) { "100" }
  let(:images) { double(:image).as_null_object }

  before :each do
    allow(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
    allow(blog_post).to receive(:images).and_return images
  end

  describe "#find_model" do
    it "calls unscoped_find_by with the blog_post_id" do
      expect(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
      get :index, :blog_post_id => blog_post_id
    end

    it "assigns to @blog_post" do
      get :index, :blog_post_id => blog_post_id
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end

  describe "#index" do
    it "assigns to @images" do
      get :index, :blog_post_id => blog_post_id
      expect(assigns[:images]).to eq(images)
    end
  end

  describe "#create" do

    before :each do
      allow(Ckeditor::Image).to receive(:new).and_return images
    end

    context "invalid image" do

      before :each do
        allow(images).to receive(:save).and_return false
      end

      it "returns nothing when image can't save" do
        get :create, :blog_post_id => blog_post_id
        expect(response.body).to eq " "
      end

    end

    context "valid image" do

      let(:image_json_output) { "image_json_output" }

      before :each do
        allow(images).to receive(:save).and_return true
      end

      it "returns a ckeditor call when it's a CKEditor all" do
        get :create, :blog_post_id => blog_post_id, :CKEditor => "true", :CKEDITORFuncNum => 100
        expect(response.body).to include("window.parent.CKEDITOR.tools.callFunction")
      end

      it "returns the id and type of the image when it's not a CKEditor call" do
        allow(images).to receive(:to_json).and_return image_json_output
        get :create, :blog_post_id => blog_post_id
        expect(response.body).to eq image_json_output
      end

      it "it assigns the image to the model" do
        expect(blog_post).to receive(:images)
        get :create, :blog_post_id => blog_post_id
      end
    end

  end

  describe "#destroy" do
    let(:image_id) { "100" }

    it "calls the destroy method on the image" do
      expect(images).to receive(:destroy)
      post :destroy, :blog_post_id => blog_post_id, :id => image_id
    end

    it "renders nothing" do
      post :destroy, :blog_post_id => blog_post_id, :id => image_id
      expect(response.body).to eq " "
    end
  end

end
