class CreateSimpleBlogPosts < ActiveRecord::Migration
  def change
    create_table :simple_blog_posts do |t|
      t.string :title
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
  end
end
