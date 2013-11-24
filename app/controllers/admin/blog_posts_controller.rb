class Admin::BlogPostsController < Admin::BaseController
  def index
    @blog_posts = BlogPost.all
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
    @blog_post = BlogPost.find_by!(:slug => params[:id])
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

  private

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :published_at)
    end
end
