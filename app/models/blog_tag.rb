class BlogTag < ActiveRecord::Base
  has_many :blog_taggings
  has_many :blog_posts, through: :blog_taggings
end
