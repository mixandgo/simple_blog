class BlogPost < ActiveRecord::Base
  has_many :blog_imageable, :as => :imageable
  has_many :pictures, :through => :blog_imageable, :class_name => Ckeditor::Picture

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
    title.try(:titleize)
  end

  def self.find_tags(term)
    return unscoped.all_tags if term.blank?
    unscoped.all_tags(:conditions => "tags.name LIKE '#{term}%'")
  end

  private

  def title_to_slug
    title.parameterize
  end

  def set_slug
    self.slug = title_to_slug unless title.nil?
  end
end
