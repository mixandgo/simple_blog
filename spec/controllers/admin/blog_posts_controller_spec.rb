require 'spec_helper'

module Admin
  describe BlogPostsController do
    describe "#update" do
      let(:post) { create(:blog_post) }

      it "assigns to @blog_post" do
        patch :update, :slug => post.slug, :blog_post => {:title => "UhHa"}
        expect(assigns(:blog_post)).to eq(post)
      end

      context "attributes are valid" do
        it "sets a flash notice" do
          patch :update, :slug => post.slug, :blog_post => {:title => "UhHa"}
          expect(flash[:notice]).not_to be_nil
        end

        it "redirects to the posts list page" do
          patch :update, :slug => post.slug, :blog_post => {:title => "UhHa"}
          expect(response).to redirect_to(admin_blog_posts_path)
        end
      end

      context "attributes ar invalid" do
        let(:post) { create(:blog_post, :title => "Initial title", :body => "Initial body") }

        it "sets the alert flash" do
          invalid_title = "a" * 100 # too long
          patch :update, :slug => post.slug, :blog_post => {:title => invalid_title}
          expect(flash[:alert]).not_to be_nil
        end

        it "renders the edit template" do
          invalid_title = "a" * 100 # too long
          patch :update, :slug => post.slug, :blog_post => {:title => invalid_title}
          expect(response).to render_template('blog_posts/edit')
        end
      end

      context "can update an unpublished post" do
        it "redirects to the posts list page" do
          patch :update, :slug => post.slug, :blog_post => {:published_at => nil}
          expect(response).to redirect_to(admin_blog_posts_path)
        end
      end
    end

    describe "#create" do
      let(:params) { attributes_for(:blog_post, :title => "Cool post",
                                    :body => "Cool post body",
                                    :description => "Cool post description") }

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

    describe "#index" do
      let(:post) { double("post") }

      it "returns all unscoped blog posts" do
        expect(BlogPost).to receive(:unscoped).and_return [post]
        get :index
        expect(assigns(:blog_posts)).to eq([post])
      end
    end

    describe "#get_tags" do
      let(:tag) { double("tag", :name => "tag") }
      let(:term) { "search_term" }
      let(:blog_post) { double("BlogPost") }

      before :each do
        allow(BlogPost).to receive(:unscoped).and_return blog_post
      end

      it "assigns @tags with the resulting tags" do
        allow(blog_post).to receive(:all_tags).and_return [tag]
        get :get_tags
        expect(assigns(:tags)).to eq([tag])
      end

      it "returns tags filtered by term" do
        expect(blog_post).to receive(:all_tags).with(:conditions => "tags.name LIKE '#{term}%'").and_return [tag]
        get :get_tags, :term => term
      end

      it "returns a json of the tags name" do
        expected_json = [tag.name].to_json
        allow(blog_post).to receive(:all_tags).and_return [tag]
        get :get_tags
        expect(response.body).to eq expected_json
      end
    end
  end
end
