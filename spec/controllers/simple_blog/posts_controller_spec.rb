require 'spec_helper'

module SimpleBlog
  describe PostsController do
    describe "#index" do
      it "assigns published posts to @posts" do
        post = FactoryGirl.create(:post)
        FactoryGirl.create(:post, :published_at => nil)
        get :index, :use_route => :simple_blog
        expect(assigns(:posts)).to eq([post])
      end

      it "renders the index template" do
        get :index, :use_route => :simple_blog
        expect(response).to render_template('posts/index')
      end
    end

    describe "#create" do
      let(:params) { FactoryGirl.attributes_for(:post, :title => "Cool post") }

      it "assigns to @post" do
        post :create, :post => params, :use_route => :simple_blog
        expect(assigns(:post)).to be_a(Post)
      end

      context "attributes are valid" do
        it "creates a new record" do
          expect {
            post :create, :post => params, :use_route => :simple_blog
          }.to change(Post, :count).by(1)
        end

        it "sets a flash notice" do
          post :create, :post => params, :use_route => :simple_blog
          expect(flash[:notice]).not_to be_nil
        end

        it "redirects to the post details page" do
          post :create, :post => params, :use_route => :simple_blog
          expect(response).to redirect_to(Post.last)
        end
      end

      context "attributes are invalid" do
        it "doesn't create a new record" do
          expect {
            post :create, :post => {:foo => :bar}, :use_route => :simple_blog
          }.to_not change(Post, :count)
        end

        it "sets a flash alert" do
          post :create, :post => {:foo => :bar}, :use_route => :simple_blog
          expect(flash[:alert]).not_to be_nil
        end

        it "renders the new post form" do
          post :create, :post => {:foo => :bar}, :use_route => :simple_blog
          expect(response).to render_template('posts/new')
        end
      end
    end

    describe "#new" do
      it "assigns a new Post to @post" do
        get :new, :use_route => :simple_blog
        expect(assigns[:post]).to be_a_new(Post)
      end

      it "renders the new template" do
        get :new, :use_route => :simple_blog
        expect(response).to render_template('posts/new')
      end
    end

    describe "#show" do
      let(:post) { FactoryGirl.create(:post) }

      it "assigns @post" do
        get :show, :slug => post.slug, :use_route => :simple_blog
        expect(assigns(:post)).to eq(post)
      end

      it "renders the show template" do
        get :show, :slug => post.slug, :use_route => :simple_blog
        expect(response).to render_template('posts/show')
      end

      it "renders a 404 if the post can't be found" do
        expect {
          get :show, :slug => "invalid-slug", :use_route => :simple_blog
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
