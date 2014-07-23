class CreateImageables < ActiveRecord::Migration
  def change
    create_table :imageables do |t|
      t.references :imageable, polymorphic: true
      t.references :ckeditor_assets
      t.timestamps
    end
  end
end
