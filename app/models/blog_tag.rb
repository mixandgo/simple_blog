class BlogTag < ActiveRecord::Base
  has_many :taggings
  has_many :blog_posts,through: :taggings
end
