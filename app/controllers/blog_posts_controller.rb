class BlogPostsController < ApplicationController

  before_filter :find_blog_post!, :only => :show

  def index
    @blog_posts = BlogPost.all
  end

  def filter
    @blog_posts = BlogPost.tagged_with(blog_post_params[:tag], :on => :tags)
    render :index
  end

  def show
    @blog_post_presenter = BlogPostPresenter.new(@blog_post)
  end

  private

    def blog_post_params
      params.permit(:tag, :slug)
    end

    def find_blog_post!
      @blog_post = BlogPost.unscoped_find_by!(blog_post_params)
    end
end
