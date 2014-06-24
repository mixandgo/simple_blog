class Admin::BlogPostsController < Admin::BaseController
  def index
    @blog_posts = BlogPost.unscoped
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
    permitted = slug_params
    @blog_post = BlogPost.unscoped.find_blog_post!(permitted.fetch(:id))
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
    permitted = slug_params
    @blog_post = BlogPost.unscoped.find_blog_post!(permitted.fetch(:id))
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

    def slug_params
      params.permit(:id)
    end
end
