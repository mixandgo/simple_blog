module SimpleBlog
  class PostsController < ApplicationController
    def new
      @post = Post.new
    end

    def create
      post = Post.create(post_params)
      flash.notice = "\"#{post.title}\" has been created"
      redirect_to post
    end

    def index
      @posts = Post.all
    end

    def show
      @post = Post.where(:slug => params[:id]).first
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :published_at)
      end
  end
end
