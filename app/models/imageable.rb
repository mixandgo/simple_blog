class Imageable < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  belongs_to :images, :foreign_key => :ckeditor_assets_id, :class_name => Ckeditor::Image
end
