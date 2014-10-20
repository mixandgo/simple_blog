require 'blog_markdown'

class BlogPost < ActiveRecord::Base
  include BlogMarkdown

  has_many :images, :class_name => "BlogImage", :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => :all_blank

  before_save :set_slug
  acts_as_taggable
  acts_as_taggable_on :keywords

  validates :title, :uniqueness => true, :presence => true, :length => {:maximum => 72}
  validates :body, :presence => true
  validates :description, :presence => true, :if => :published?

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

  def find_image_by(id)
    images.where(id).first
  end

  def self.unscoped_find_by!(options)
    unscoped.find_by!(options)
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
