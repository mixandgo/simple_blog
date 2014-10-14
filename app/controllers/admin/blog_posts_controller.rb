class Admin::BlogPostsController < Admin::BaseController

  before_filter :find_blog_post!, :only => [:edit, :update, :destroy, :delete_blog_image]

  def index
    @blog_posts = BlogPost.unscoped
  end

  def new
    @blog_post = BlogPost.new
    @blog_post_image = @blog_post.blog_images.build
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:notice] = t('.flash_notice')
      redirect_to admin_blog_posts_path
    else
      flash[:alert] = t('.flash_alert')
      render :action => :new
    end
  end

  def edit
    @blog_images = @blog_post.blog_images.all
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

  def destroy
    @blog_post.destroy
    flash[:notice] = t('.flash_notice')
    redirect_to admin_blog_posts_path
  end

  def get_tags
    @tags = BlogPost.find_tags(tag_params)
    render json: @tags.map(&:name)
  end

  def delete_blog_image
    blog_image = @blog_post.blog_images.find_by!(:id => blog_image_params)
    blog_image.delete
    flash[:notice] = t('.flash_notice')
    redirect_to edit_admin_blog_post_path(@blog_post.id)
  end

  private

    def blog_image_params
      params.permit(:blog_image_id)[:blog_image_id]
    end

    def tag_params
      params.permit(:term)[:term]
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :description, :published_at, :tag_list, :keyword_list, :blog_images_attributes => [:image])
    end

    def find_blog_post!
      @blog_post = BlogPost.unscoped.find_by!(params.permit(:id))
    end
end
