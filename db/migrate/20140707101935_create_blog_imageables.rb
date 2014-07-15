class CreateBlogImageables < ActiveRecord::Migration
  def change
    create_table :blog_imageables do |t|
      t.references :imageable, polymorphic: true
      t.references :ckeditor_assets
    end
  end
end
