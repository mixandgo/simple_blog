class Ckeditor::Picture < Ckeditor::Asset
  belongs_to :imageable, :polymorphic => true

  mount_uploader :data, CkeditorPictureUploader, :mount_on => :data_file_name

  def url_content
    url(:content)
  end

  def self.find_associated_pictures(model_name, model_id)
    self.
      joins("JOIN blog_imageables ON blog_imageables.ckeditor_assets_id = ckeditor_assets.id").
      where("blog_imageables.imageable_type = ? AND blog_imageables.imageable_id = ?", model_name, model_id)
  end

end
