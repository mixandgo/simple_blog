class AddLanguageToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :language, :string
  end
end
