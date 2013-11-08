module SimpleBlog
  class PostsController < ApplicationController
    def index
      @posts = Post.all
    end

    def new
    end

    def create
      post = Post.create(post_params)
      flash.notice = "\"#{post.title}\" has been created"
      redirect_to post
    end

    def show
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :published_at)
      end
  end
end
