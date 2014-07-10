require 'spec_helper'

describe Admin::Ckeditor::PicturesController do
  let(:model_id) { "100" }
  let(:model_name) { "BlogPost" }
  let(:picture) { double(:picture) }

  before :each do
    allow(picture).to receive(:data=)
    allow(picture).to receive(:save)
  end

  describe "#index" do
    it "should assign all pictures" do
      allow(Ckeditor::Picture).to receive(:find_associated_pictures).
        with("model_name" => model_name, "model_id" => model_id).
        and_return picture

      get :index, :model_name => model_name, :model_id => model_id
      expect(assigns(:pictures)).to eq picture
    end
  end

  describe "#create" do
    let(:blog_post) { double(:blog_post) }

    before :each do
      allow(BlogPost).to receive(:unscoped_find).with(model_id).and_return blog_post
      allow(Ckeditor).to receive(:picture_model).and_return picture
      allow(picture).to receive(:new).and_return picture
    end

    it "should assign the article" do
      post :create, :model_name => model_name, :model_id => model_id

      expect(assigns(:article)).to eq blog_post
    end

    it "should assign the picture" do
      post :create, :model_name => model_name, :model_id => model_id

      expect(assigns(:picture)).to eq picture
    end

    context "invalid picture" do
      before :each do
        allow(picture).to receive(:save).and_return false
      end

      it "renders nothing when picture could not be saved" do
        post :create, :model_name => model_name, :model_id => model_id

        expect(response.body).to be_blank
      end
    end

    context "valid picture" do
      before :each do
        allow(picture).to receive(:save).and_return true
        allow(blog_post).to receive(:pictures).and_return []
        allow(picture).to receive(:url_content).and_return "some_url"
      end

      it "should set the picture to the article" do
        post :create, :model_name => model_name, :model_id => model_id
        expect(assigns(:article).pictures).to eq [picture]
      end

      it "renders a Ckeditor function when asset was saved and CKeditor not blank" do
        post :create, :model_name => model_name, :model_id => model_id, :CKEditor => "CKEditor"
        expect(response.body).to match("window.parent.CKEDITOR.tools.callFunction")
      end

      it "renders the picture to json when assets was saved and Ckeditor blank" do
        post :create, :model_name => model_name, :model_id => model_id
        expect(response.body).to eq picture.to_json(:only => [:id, :type])
      end
    end
  end

  describe "#destroy" do
    let(:id) { "100" }

    before :each do
      allow(Ckeditor::Picture).to receive(:find_associated_pictures).
        with("model_name" => model_name, "model_id" => model_id, "id" => id).
        and_return picture
      allow(picture).to receive(:destroy)
    end

    it "should call destroy on picture" do
      expect(picture).to receive(:destroy)

      delete :destroy, :model_name => model_name, :model_id => model_id, :id => id
    end

    it "renders nothing after picture was distroyed" do
      delete :destroy, :model_name => model_name, :model_id => model_id, :id => id

      expect(response.body).to be_blank
    end
  end
end
