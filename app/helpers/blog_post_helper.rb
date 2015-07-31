require 'blog_markdown'
require 'blog_languages'

module BlogPostHelper
  include BlogMarkdown
  include BlogLanguages

  def blog_post_tags(post)
    raw post.tag_list.map { |tag| link_to(tag, filter_posts_path(clean_up_tag(tag))) }.join(", ")
  end

  def strip_tags_for_seo(text)
    strip_tags(text).strip
  end

  def blog_post_url_with_analytics(blog_post, source, medium)
    return '' unless blog_post.published?
    campaign = "blog_post_#{blog_post.published_at.strftime('%d_%m_%Y')}"
    blog_post_url(blog_post, :utm_source => source, :utm_medium => medium, :utm_campaign => campaign)
  end

  private

    def clean_up_tag(tag)
      tag.gsub(" ", "-")
    end

end
