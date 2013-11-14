module SimpleBlog
  class PostsController < ApplicationController
    def new
      @post = Post.new
    end

    def create
      post = Post.new(post_params)
      if post.save
        flash.notice = t('.flash_notice')
        redirect_to post
      else
        flash.notice = t('.flash_alert')
        redirect_to post
      end
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
