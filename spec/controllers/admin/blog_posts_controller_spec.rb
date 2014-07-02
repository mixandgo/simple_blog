require 'spec_helper'

module Admin
  describe BlogPostsController do
    describe "#update" do
      let(:post) { create(:blog_post) }

      it "assigns to @blog_post" do
        patch :update, :id => post.id, :blog_post => {:title => "UhHa"}
        expect(assigns(:blog_post)).to eq(post)
      end

      context "attributes are valid" do
        it "sets a flash notice" do
          patch :update, :id => post.id, :blog_post => {:title => "UhHa"}
          expect(flash[:notice]).not_to be_nil
        end

        it "redirects to the posts list page" do
          patch :update, :id => post.id, :blog_post => {:title => "UhHa"}
          expect(response).to redirect_to(admin_blog_posts_path)
        end
      end

      context "attributes ar invalid" do
        let(:post) { create(:blog_post, :title => "Initial title", :body => "Initial body") }

        it "sets the alert flash" do
          invalid_title = "a" * 100 # too long
          patch :update, :id => post.id, :blog_post => {:title => invalid_title}
          expect(flash[:alert]).not_to be_nil
        end

        it "renders the edit template" do
          invalid_title = "a" * 100 # too long
          patch :update, :id => post.id, :blog_post => {:title => invalid_title}
          expect(response).to render_template('blog_posts/edit')
        end
      end

      context "can update an unpublished post" do
        it "redirects to the posts list page" do
          patch :update, :id => post.id, :blog_post => {:published_at => nil}
          expect(response).to redirect_to(admin_blog_posts_path)
        end
      end
    end

    describe "#new" do

      let(:post_id) { 100 }
      let(:blog_post) { double("blog_post", :id => post_id) }

      it "creates a new empty blog post and redirects to the edit page" do
        expect(BlogPost).to receive(:create).and_return blog_post
        get :new
        expect(response).to redirect_to(edit_admin_blog_post_path(blog_post.id))
      end

    end

    describe "#index" do
      let(:post) { double("post") }

      it "returns all unscoped blog posts" do
        expect(BlogPost).to receive(:unscoped).and_return [post]
        get :index
        expect(assigns(:blog_posts)).to eq([post])
      end
    end
  end
end
