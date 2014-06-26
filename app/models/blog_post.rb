class BlogPost < ActiveRecord::Base
  before_save :set_slug
  acts_as_taggable

  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}
  validates :description, :presence => true
  validates :body, :presence => true

  default_scope { where("published_at IS NOT NULL") }

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
