require 'blog_markdown'
require 'blog_languages'

module BlogPostHelper
  include BlogMarkdown
  include BlogLanguages

  def blog_post_tags(post)
    raw post.tag_list.map { |tag| link_to(tag, filter_posts_path(tag)) }.join(", ")
  end

  def strip_tags_for_seo(text)
    strip_tags(text).strip
  end

end
