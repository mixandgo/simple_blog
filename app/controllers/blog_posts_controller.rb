class BlogPostsController < ApplicationController
  def index
    if params[:tag]
      @blog_posts = BlogPost.tagged_with(params[:tag])
    else
      @blog_posts = BlogPost.published
    end
  end

  def show
    @blog_post = BlogPost.find_by!(:slug => params[:slug])
  end
end
