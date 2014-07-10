class BlogImageable < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  belongs_to :pictures, :foreign_key => :ckeditor_assets_id, :class_name => Ckeditor::Picture
end
