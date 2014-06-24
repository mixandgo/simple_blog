class BlogPostsController < ApplicationController
  def index
    @blog_posts = blog_post_params.has_key?(:tag) ? BlogPost.tagged_with(blog_post_params.fetch(:tag)) : BlogPost.all
  end

  def show
    @blog_post = find_blog_post!(params)
  end

  private

  def blog_post_params
    params.permit(:tag, :slug)
  end

  def find_blog_post!(params)
    BlogPost.where(blog_post_params).first!
  end
end
