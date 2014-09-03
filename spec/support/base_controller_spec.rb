require 'spec_helper'

shared_examples "a controller for attaching images to models" do |actions|
  actions.each_pair do |id_name, id|
    context "index controller method" do
      let(:images) { double("images").as_null_object }

      before :each do
        allow(model).to receive(:images).and_return(images)
      end

      specify "assigns images" do
        get :index, id_name => id
        expect(assigns[:images]).to eq(images)
      end
    end

    context "create controller method" do
      let(:image) { double(:image).as_null_object }

      before :each do
        allow(Ckeditor::Image).to receive(:new).and_return image
        allow(image).to receive(:data=)
      end

      context "invalid image" do

        before :each do
          allow(image).to receive(:save).and_return false
        end

        specify "returns nothing when image can't save" do
          get :create, id_name => id
          expect(response.body).to eq " "
        end

      end

      context "valid image" do

        let(:image_json_output) { "image_json_output" }

        before :each do
          allow(model).to receive(:images).and_return image
          allow(image).to receive(:save).and_return true

        end

        specify "returns a ckeditor call when it's a CKEditor all" do
          get :create, id_name => id, :CKEditor => "true", :CKEDITORFuncNum => 100
          expect(response.body).to include("window.parent.CKEDITOR.tools.callFunction")
        end

        specify "returns the id and type of the image when it's not a CKEditor call" do
          allow(image).to receive(:to_json).and_return image_json_output
          get :create, id_name => id
          expect(response.body).to eq image_json_output
        end

        specify "it assigns the image to the model" do
          expect(model).to receive(:images)
          get :create, id_name => id
        end
      end

    end

    context "destroy controller method" do
      let(:image_id) { "100" }
      let(:image) { double("image").as_null_object }

      before :each do
        allow(model).to receive(:images).and_return image
      end

      specify "calls the destroy method on the image" do
        expect(image).to receive(:destroy)
        post :destroy, id_name => id, :id => image_id
      end

      specify "renders nothing" do
        allow(image).to receive(:destroy)
        post :destroy, id_name => id, :id => image_id
        expect(response.body).to eq " "
      end
    end
  end
end
