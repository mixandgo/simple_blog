require 'spec_helper'

module Admin
  describe BlogPostsController do
    describe "#create" do
      let(:params) { FactoryGirl.attributes_for(:blog_post, :title => "Cool post") }

      it "assigns to @blog_post" do
        post :create, :blog_post => params
        expect(assigns(:blog_post)).to be_a(BlogPost)
      end

      context "attributes are valid" do
        it "creates a new record" do
          expect {
            post :create, :blog_post => params
          }.to change(BlogPost, :count).by(1)
        end

        it "sets a flash notice" do
          post :create, :blog_post => params
          expect(flash[:notice]).not_to be_nil
        end

        it "redirects to the post details page" do
          post :create, :blog_post => params
          expect(response).to redirect_to(edit_admin_blog_post_path(BlogPost.last))
        end
      end

      context "attributes are invalid" do
        it "doesn't create a new record" do
          expect {
            post :create, :blog_post => {:foo => :bar}
          }.to_not change(BlogPost, :count)
        end

        it "sets a flash alert" do
          post :create, :blog_post => {:foo => :bar}
          expect(flash[:alert]).not_to be_nil
        end

        it "renders the new post form" do
          post :create, :blog_post => {:foo => :bar}
          expect(response).to render_template('blog_posts/new')
        end
      end
    end

    describe "#new" do
      it "assigns a new Post to @blog_post" do
        get :new
        expect(assigns[:blog_post]).to be_a_new(BlogPost)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template('blog_posts/new')
      end
    end

  end
end
