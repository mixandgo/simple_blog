class Admin::BlogImagesController < Admin::BaseController

  before_filter :find_blog_image!, :only => [:destroy]

  def destroy
    @blog_image.delete
    flash[:notice] = t('.flash_notice')
    redirect_to edit_admin_blog_post_path(@blog_image.blog_post_id)
  end

  private

  def find_blog_image!
    @blog_image = BlogImage.find_by!(params.permit(:id))
  end
end
