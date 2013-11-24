class BlogTagging < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :blog_tag
end
