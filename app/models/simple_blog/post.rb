module SimpleBlog
  class Post < ActiveRecord::Base
    validates :title, :presence => true, :length => {:maximum => 72}

    scope :published, -> { where("published_at IS NOT NULL") }
  end
end
