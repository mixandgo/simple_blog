class BlogPostsController < ApplicationController
  def index
    permitted = blog_post_params
    @blog_posts = permitted.has_key?(:tag) ? BlogPost.tagged_with(permitted.fetch(:tag)) : BlogPost.all
  end

  def show
    @blog_post = BlogPost.find_blog_post!(blog_post_params.fetch(:slug))
  end

  private

  def blog_post_params
    params.permit(:tag, :slug)
  end
end
