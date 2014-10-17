require 'spec_helper'

module Admin
  describe BlogPostsController, :type => :controller do
    describe "#create" do
      let(:params) { {:title => ""} }
      let(:blog_post) { double.as_null_object }

      before :each do
        allow(BlogPost).to receive(:new).with(params).and_return blog_post
      end

      it "instantiates a new blog post with the specified params" do
        expect(BlogPost).to receive(:new).with(params)
        post :create, :blog_post => params
      end

      it "saves the new blog post" do
        expect(blog_post).to receive(:save)
        post :create, :blog_post => params
      end

      context "valid parameters" do
        before :each do
          allow(blog_post).to receive(:save).and_return true
        end

        it "redirects to the index page" do
          post :create, :blog_post => params
          expect(response).to redirect_to(admin_blog_posts_path)
        end

        it "sets a flash notice" do
          post :create, :blog_post => params
          expect(flash[:notice]).not_to be_nil
        end
      end

      context "invalid parameters" do
        before :each do
          allow(blog_post).to receive(:save).and_return false
        end

        it "renders the new template" do
          post :create, :blog_post => params
          expect(response).to render_template('blog_posts/new')
        end

        it "sets the alert flash" do
          post :create, :blog_post => params
          expect(flash[:alert]).not_to be_nil
        end
      end
    end

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

    describe "#edit" do
      let(:id) { "100" }
      let(:post) { double.as_null_object }
      let(:images) { double.as_null_object }

      before :each do
        allow(BlogPost).to receive(:unscoped_find_by!).with(:id => id).and_return post
      end

      it "assigns the @blog_post" do
        get :edit, :id => id
        expect(assigns(:blog_post)).to eq(post)
      end

      it "renders the edit template" do
        get :edit, :id => id
        expect(response).to render_template('blog_posts/edit')
      end
    end

    describe "#new" do
      let(:blog_post) { double.as_null_object }
      let(:blog_images) { double.as_null_object }

      before :each do
        allow(BlogPost).to receive(:new).and_return blog_post
        allow(blog_post).to receive(:images).and_return blog_images
      end

      it "creates a new empty blog post" do
        expect(BlogPost).to receive(:new)
        get :new
      end

      it "build an empty image" do
        expect(blog_images).to receive(:build)
        get :new
      end

      it "assigns to blog_post" do
        get :new
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template('blog_posts/new')
      end
    end

    describe "#index" do
      let(:blog_post) { double("BlogPost") }

      before :each do
        allow(BlogPost).to receive(:unscoped).and_return [blog_post]
      end

      it "returns all unscoped blog posts" do
        expect(BlogPost).to receive(:unscoped)
        get :index
      end

      it "assigns to @blog posts" do
        get :index
        expect(assigns(:blog_posts)).to eq([blog_post])
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
