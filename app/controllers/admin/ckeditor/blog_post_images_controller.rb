class Admin::Ckeditor::BlogPostImagesController < Admin::Ckeditor::BaseController
  before_filter :find_model

  private
  
    def find_model
      @model = BlogPost.unscoped_find_by!(params.permit(:blog_post_id)[:blog_post_id])
    end
end
