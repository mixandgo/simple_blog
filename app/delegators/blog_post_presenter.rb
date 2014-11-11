require 'delegate'

class BlogPostPresenter < SimpleDelegator

  def seo_tags
    tags = {"description" => model.description,
            "keywords" => model.keyword_list}
    set_hash_meta_tags(tags)
  end

  def twitter_card
    tags = {"twitter:card" => "summary",
            "twitter:title" => model.pretty_title,
            "twitter:description" => model.description,
            "twitter:url" => model.to_url}
    tags["twitter:site"] = SimpleBlog.twitter_site_name if SimpleBlog.twitter_site_name.present?
    set_hash_meta_tags(tags) + set_image_meta_tags(model.images, "twitter:image")
  end

  # also takes care of google plus open graph meta tags
  def facebook_card
    tags = {"og:type" => "article",
            "og:title" => model.pretty_title,
            "og:description" => model.description,
            "og:url" => model.to_url}
    tags["fb:app_id"] = SimpleBlog.fb_app_id if SimpleBlog.fb_app_id.present?
    set_hash_meta_tags(tags, "property") + set_image_meta_tags(model.images, "og:image", "property")
  end

  def set_meta_tags
    (seo_tags + twitter_card + facebook_card).html_safe
  end

  def model
    __getobj__
  end

  private

  def meta_tag(name, content, type="name")
    "<meta #{type}='#{name}' content='#{content}'>"
  end

  def set_hash_meta_tags(tags, type = "name")
    tags.collect { |k,v| meta_tag("#{k}",v,type) }.join
  end

  def set_image_meta_tags(images, name, type = "name")
    images.collect { |image| meta_tag(name, image.image.url, type) }.join
  end

end
