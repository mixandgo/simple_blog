class BlogPostsController < ApplicationController

  before_filter :check_tag_exists!, :only => :filter
  before_filter :find_blog_post!, :only => :show

  def index
    @blog_posts = BlogPost.all
  end

  def filter
    @blog_posts = BlogPost.tagged_with(@tag, :on => :tags)
    render :index
  end

  def show
    @blog_post_presenter = BlogPostPresenter.new(@blog_post)
  end

  private

    def blog_post_params
      params.permit(:slug)
    end

    def blog_tag_params
      params.permit(:tag)
    end

    def find_blog_post!
      @blog_post = BlogPost.unscoped_find_by!(blog_post_params)
    end

    def check_tag_exists!
      @tag = ActsAsTaggableOn::Tag.find_by!(:name => blog_tag_params[:tag])
    end
end
