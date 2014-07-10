class Admin::Ckeditor::PicturesController < Admin::BaseController
  respond_to :html, :json
  layout 'ckeditor/application'

  before_filter :find_picture, :only => :destroy

  def index
    @pictures = Ckeditor::Picture.find_associated_pictures(picture_params)

    respond_with(@pictures)
  end

  def create
    @article = BlogPost.unscoped_find(picture_params[:model_id])
    @picture = Ckeditor.picture_model.new

    render_with_assets(@picture)
  end

  def destroy
    @picture.destroy
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

        # picture = Ckeditor.asset_adapter.find_all.find(asset.id)
        @article.pictures << asset
        render :text => body
      else
        render :nothing => true
      end
    end

    def picture_params
      params.permit(:model_name, :model_id, :id)
    end

    def find_picture
      @picture = Ckeditor::Picture.find_associated_pictures(picture_params)
    end
end
