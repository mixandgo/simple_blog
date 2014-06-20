class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
  end
end
