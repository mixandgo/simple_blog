class BlogPost < ActiveRecord::Base
  before_save :set_slug
  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}

  has_many :taggings
  has_many :blog_tags,through: :taggings

  scope :published, -> { where("published_at IS NOT NULL") }

  def to_param
    title_to_slug
  end

  def published?
    !!published_at
  end

  private

  def set_slug
    self.slug = title_to_slug
  end

  def title_to_slug
    title.parameterize
  end
end
