require 'spec_helper'

module Admin
  describe BlogImagesController, :type => :controller do
    describe "#destroy" do
      let(:id) { "100" }
      let(:blog_post_id) { "100" }
      let(:blog_image) { double("blog_image", :blog_post_id => blog_post_id).as_null_object }

      before :each do
        allow(BlogImage).to receive(:find_by!).with(:id => id).and_return blog_image
      end

      it "deletes the blog image" do
        expect(blog_image).to receive(:delete)
        delete :destroy, :id => id
      end

      it "sets a flash notice" do
        delete :destroy, :id => id
        expect(flash[:notice]).not_to be_nil
      end

      it "redirects to the blog_post edit page" do
        delete :destroy, :id => id
        expect(response).to redirect_to(edit_admin_blog_post_path(blog_post_id))
      end

    end
  end
end
