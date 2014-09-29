require 'spec_helper'

describe Admin::Ckeditor::BlogPostImagesController, :type => :controller do

  let(:blog_post) { instance_double("BlogPost").as_null_object }
  let(:blog_post_id) { "100" }
  let(:images) { double(:images).as_null_object }
  let(:image) { instance_double("Image").as_null_object }

  before :each do
    allow(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
    allow(blog_post).to receive(:images).and_return images
  end

  describe "#index" do
    it_behaves_like "a controller that needs @blog_post assigned", {:controller => :index, :method => :get, :options => {}}

    it "assigns to @images" do
      xhr :get, :index, :blog_post_id => blog_post_id
      expect(assigns[:images]).to eq(images)
    end

    it "responds with the images" do
      expect(controller).to receive(:respond_with).with(images)
      xhr :get, :index, :blog_post_id => blog_post_id
    end
  end

  describe "#create" do
    let(:image_json_output) { "image_json_output" }

    before :each do
      allow(Ckeditor::Image).to receive(:new).and_return image
      allow(image).to receive(:to_json).and_return image_json_output
    end

    it_behaves_like "a controller that needs @blog_post assigned", {:controller => :create, :method => :get, :options => {}}

    context "invalid image" do

      before :each do
        allow(image).to receive(:save).and_return false
      end

      it "returns nothing when image can't save" do
        xhr :get, :create, :blog_post_id => blog_post_id
        expect(response.body).to eq " "
      end

    end

    context "valid image" do

      let(:image_json_output) { "image_json_output" }

      before :each do
        allow(image).to receive(:save).and_return true
        allow(image).to receive(:to_json).and_return image_json_output
      end

      it "returns a ckeditor js call when 'CKEditor' send through params" do
        xhr :get, :create, :blog_post_id => blog_post_id, :CKEditor => "true", :CKEDITORFuncNum => 100
        expect(response.body).to include("window.parent.CKEDITOR.tools.callFunction")
      end

      it "returns an image json output as default" do
        allow(image).to receive(:to_json).and_return image_json_output
        xhr :get, :create, :blog_post_id => blog_post_id
        expect(response.body).to eq image_json_output
      end

      it "it assigns the image to the model" do
        expect(blog_post).to receive(:images)
        xhr :get, :create, :blog_post_id => blog_post_id
      end
    end

  end

  describe "#destroy" do
    let(:image_id) { "100" }

    before :each do
      allow(blog_post).to receive(:find_image_by).with("id" => image_id).and_return image
    end

    it_behaves_like "a controller that needs @blog_post assigned", {:controller => :destroy, :method => :post, :options => {:id => "100"}}

    it "uses the image with the specified id" do
      expect(blog_post).to receive(:find_image_by).with("id" => image_id)
      xhr :post, :destroy, :blog_post_id => blog_post_id, :id => image_id

    end

    it "calls the destroy method on the image" do
      expect(image).to receive(:destroy)
      xhr :post, :destroy, :blog_post_id => blog_post_id, :id => image_id
    end

    it "calls the remove_data! method on the image" do
      expect(image).to receive(:remove_data!)
      xhr :post, :destroy, :blog_post_id => blog_post_id, :id => image_id
    end

    it "renders nothing" do
      xhr :post, :destroy, :blog_post_id => blog_post_id, :id => image_id
      expect(response.body).to eq " "
    end
  end

end
