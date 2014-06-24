class BlogPostsController < ApplicationController

  before_filter :find_blog_post!, :only => :show

  def index
    @blog_posts = BlogPost.all
  end

  def filter
    @blog_posts = BlogPost.tagged_with(blog_post_params[:tag])
    render :index
  end

  def show
  end

  private

    def blog_post_params
      params.permit(:tag, :slug)
    end

    def find_blog_post!
      @blog_post = BlogPost.find_by!(blog_post_params)
    end
end
