class BlogPost < ActiveRecord::Base
  before_save :generate_random_title
  acts_as_taggable

  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}, :if => :published?
  validates :description, :presence => true, :if => :published?
  validates :body, :presence => true, :if => :published?

  default_scope { where("published_at IS NOT NULL") }

  def safe_body
    body.nil? ? "" : body.html_safe
  end

  def safe_description
    description.nil? ? "" : description.html_safe
  end

  def to_param
    title_to_slug
  end

  def published?
    !!published_at
  end

  def pretty_title
    title.titleize
  end

  private

  def generate_random_title
    self.title = (0...8).map { (65 + rand(26)).chr }.join if title.nil?
    self.slug = title_to_slug
  end

  def title_to_slug
    title.parameterize
  end

end
