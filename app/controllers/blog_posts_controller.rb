class BlogPostsController < ApplicationController

  before_filter :find_tag!, :only => :filter
  before_filter :find_blog_post!, :only => :show
  # default_scope order('published_at')

  def index
    @blog_posts = BlogPost.page(params[:page]).per(5)
    # @blog_posts = BlogPost.order('published_at').page(params[:page]).per(5)
  end

  def filter
    @blog_posts = BlogPost.tagged_with(@tag, :on => :tags)
    @page_title = "#{@tag.name.titleize} #{t(".page_title_text")}"
    render :index
  end

  def show
    @blog_post_presenter = BlogPostPresenter.new(@blog_post)
    @page_title = @blog_post.title
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

    def find_tag!
      @tag = ActsAsTaggableOn::Tag.find_by!(:name => blog_tag_params[:tag])
    end
end
