module SimpleBlog
  class Post < ActiveRecord::Base
    validates :title, :presence => true, :length => {:maximum => 72}
  end
end
