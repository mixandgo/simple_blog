class BlogImages < ActiveRecord::Migration
  def change
    create_table :blog_images do |t|
      t.integer :blog_post_id
      t.string :image
    end
  end
end
