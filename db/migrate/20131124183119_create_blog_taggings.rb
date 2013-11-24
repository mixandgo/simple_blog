class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.integer :blog_post_id, :blog_tag_id

      t.timestamps
    end

    add_index :blog_taggings, :blog_post_id
    add_index :blog_taggings, :blog_tag_id
  end
end
