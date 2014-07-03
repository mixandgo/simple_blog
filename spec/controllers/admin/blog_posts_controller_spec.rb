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

      it "creates a new empty blog post" do
        expect(BlogPost).to receive(:create).and_return blog_post
        get :new
      end

      it "redirects to the edit page" do
        allow(BlogPost).to receive(:create).and_return blog_post
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

    describe "#destroy" do
      let(:blog_post) { create(:blog_post) }

      it "destroys the blog post specified by id" do
        delete :destroy, :id => blog_post.id
        expect(BlogPost.count).to eq(0)
      end

      it "sets a flash notice that the post was deleted" do
        delete :destroy, :id => blog_post.id
        expect(flash[:notice]).not_to be_nil
      end

      it "redirects to the posts list page" do
        delete :destroy, :id => blog_post.id
        expect(response).to redirect_to(admin_blog_posts_path)
      end
    end

    describe "#get_tags" do
      let(:tag) { double("tag", :name => "tag") }
      let(:term) { "search_term" }

      before :each do
        allow(BlogPost).to receive(:find_tags).and_return [tag]
      end

      it "assigns @tags with the resulting tags" do
        get :get_tags
        expect(assigns(:tags)).to eq([tag])
      end

      it "returns tags filtered by term" do
        expect(BlogPost).to receive(:find_tags).with(term).and_return [tag]
        get :get_tags, :term => term
      end

      it "returns a json of the tags name" do
        expected_json = [tag.name].to_json
        get :get_tags
        expect(response.body).to eq expected_json
      end
    end
  end
end
