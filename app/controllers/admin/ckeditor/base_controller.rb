class Admin::Ckeditor::BaseController < Admin::BaseController
  respond_to :html, :json
  layout 'ckeditor/application'

  before_filter :find_image, :only => :destroy

  def index
    @images = @model.images

    respond_with(@images)
  end

  def create
    @image = Ckeditor::Image.new

    render_with_assets(@image)
  end

  def destroy
    @image.delete
    render :nothing => true
  end

  private

    def render_with_assets(asset)
      file = params[:CKEditor].blank? ? params[:qqfile] : params[:upload]
      asset.data = Ckeditor::Http.normalize_param(file, request)

      callback = ckeditor_before_create_asset(asset)

      if callback && asset.save
        body = params[:CKEditor].blank? ? asset.to_json(:only=>[:id, :type]) : %Q"<script type='text/javascript'>
          window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{config.relative_url_root}#{Ckeditor::Utils.escape_single_quotes(asset.url_content)}');
        </script>"

        @model.images << asset
        render :text => body
      else
        render :nothing => true
      end
    end

    def find_image
      @image = @model.images.where(params.permit(:id))
    end
end
