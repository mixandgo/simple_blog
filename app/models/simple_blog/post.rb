module SimpleBlog
  class Post < ActiveRecord::Base
    before_save :set_slug
    validates :title, :presence => true, :length => {:maximum => 72}

    scope :published, -> { where("published_at IS NOT NULL") }

    def to_param
      title_to_slug
    end

    private

      def set_slug
        self.slug = title_to_slug
      end

      def title_to_slug
        title.parameterize
      end
  end
end
