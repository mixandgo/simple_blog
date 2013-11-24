class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.published
  end

  def show
    @blog_post = BlogPost.find_by!(:slug => params[:slug])
  end
end
