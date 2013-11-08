class AddSlugToPost < ActiveRecord::Migration
  def change
    add_column :simple_blog_posts, :slug, :string
  end
end
