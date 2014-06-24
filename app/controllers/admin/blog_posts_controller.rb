class Admin::BlogPostsController < Admin::BaseController

  before_filter :find_blog_post!, :only => [:edit, :update]

  def index
    @blog_posts = BlogPost.unscoped
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash.notice = t('.flash_notice')
      redirect_to edit_admin_blog_post_path(@blog_post)
    else
      flash.alert = t('.flash_alert')
      render :action => :new
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      flash[:notice] = t('.flash_notice')
      redirect_to admin_blog_posts_path
    else
      flash[:alert] = t('.flash_alert')
      render :action => :edit
    end
  end

  private

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :published_at, :tag_list)
    end

    def find_blog_post!
      @blog_post = BlogPost.unscoped.find_by!(params.permit(:slug))
    end
end
