require 'blog_markdown'

module BlogPostHelper
  include BlogMarkdown

  def blog_post_tags(post)
    raw post.tag_list.map { |tag| link_to(tag, filter_posts_path(tag)) }.join(", ")
  end

  def strip_tags_for_seo(text)
    strip_tags(text).strip
  end

  def seo_tags(blog_post)
    render "blog_posts/seo_tags", {:blog_post => blog_post}
  end

end
