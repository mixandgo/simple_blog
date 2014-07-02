class BlogPost < ActiveRecord::Base
  before_save :set_slug
  acts_as_taggable

  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}, :on => :update
  validates :body, :presence => true, :on => :update
  validates :description, :presence => true, :on => :update, :if => :published?

  default_scope { where("published_at IS NOT NULL") }

  def to_param
    title_to_slug
  end

  def published?
    !!published_at
  end

  def pretty_title
    title.nil? ? I18n.t("blog_post.empty_title") : title.titleize
  end

  private

  def title_to_slug
    title.parameterize
  end

  def set_slug
    self.slug = title_to_slug unless title.nil?
  end
end
