class Admin::BlogImagesController < Admin::BaseController

  def destroy
    blog_image = BlogImage.find_by!(params.permit(:id))
    blog_image.delete
    flash[:notice] = t('.flash_notice')
    redirect_to edit_admin_blog_post_path(blog_image.blog_post_id)
  end

end
