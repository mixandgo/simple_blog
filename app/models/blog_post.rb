class BlogPost < ActiveRecord::Base
  before_save :default_values
  acts_as_taggable

  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}, :if => :published?
  validates :description, :presence => true, :if => :published?
  validates :body, :presence => true, :if => :published?

  default_scope { where("published_at IS NOT NULL") }

  def safe_body
    body.html_safe
  end

  def safe_description
    description.html_safe
  end

  def to_param
    title_to_slug
  end

  def published?
    !!published_at
  end

  def pretty_title
    title.empty? ? I18n.t("admin.blog_posts.empty_post.title") : title.titleize
  end

  private

  def title_to_slug
    title.parameterize
  end

  def default_values
    self.body ||= ""
    self.description ||= ""
    self.title ||= ""
    self.slug = title_to_slug
  end
end
