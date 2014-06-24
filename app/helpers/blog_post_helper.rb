module BlogPostHelper

  def blog_post_tags(post)
    raw post.tag_list.map { |tag| link_to(tag, filter_posts_path(tag)) }.join(", ")
  end

end
