class Admin::Ckeditor::BlogPostImagesController < Admin::Ckeditor::BaseController
  before_filter :find_blog_post

  respond_to :json, :html
  layout 'ckeditor/application'

  def index
    @images = @blog_post.images

    respond_with(@images)
  end

  def create
    @image = Ckeditor::Image.new

    asset = create_asset_from(@image)
    if asset
      @blog_post.images << asset
      render_with_asset(asset)
    else
      render :nothing => true
    end
  end

  def destroy
    image = @blog_post.find_image_by(params.permit(:id))
    image.remove_data!
    image.destroy
    render :nothing => true
  end

  private

    def create_asset_from(image)
      file = params[:CKEditor].blank? ? params[:qqfile] : params[:upload]
      image.data = Ckeditor::Http.normalize_param(file, request)
      callback = ckeditor_before_create_asset(image)

      return image if callback && image.save
    end

    def render_with_asset(asset)
      body = params[:CKEditor].blank? ? asset.to_json(:only=>[:id, :type]) : %Q"<script type='text/javascript'>
          window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{config.relative_url_root}#{Ckeditor::Utils.escape_single_quotes(asset.url_content)}');
        </script>"
      render :text => body
    end

    def find_blog_post
      @blog_post = BlogPost.unscoped_find_by!(params.permit(:blog_post_id)[:blog_post_id])
    end
end
