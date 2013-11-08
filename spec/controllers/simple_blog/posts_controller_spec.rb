require 'spec_helper'

module SimpleBlog
  describe PostsController do
    describe "#index" do
      it "assigns @posts" do
        post = FactoryGirl.create(:post)
        get :index, :use_route => :simple_blog
        expect(assigns(:posts)).to eq([post])
      end

      it "renders the index template" do
        get :index, :use_route => :simple_blog
        expect(response).to render_template('posts/index')
      end
    end

    describe "#create" do
      let(:params) { FactoryGirl.attributes_for(:post) }

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

    describe "#new" do
      it "renders the new template" do
        get :new, :use_route => :simple_blog
        expect(response).to render_template('posts/new')
      end
    end

    describe "#show" do
      let(:post) { FactoryGirl.create(:post) }

      before :each do
        get :show, :id => post.id, :use_route => :simple_blog
      end

      it "assigns @post" do
        expect(assigns(:post)).to eq(post)
      end

      it "renders the show template" do
        expect(response).to render_template('posts/show')
      end
    end
  end
end
