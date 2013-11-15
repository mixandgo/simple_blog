module SimpleBlog
  class PostsController < ApplicationController
    def index
      @posts = Post.published
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        flash.notice = t('.flash_notice')
        redirect_to @post
      else
        flash.alert = t('.flash_alert')
        render :action => :new
      end
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
