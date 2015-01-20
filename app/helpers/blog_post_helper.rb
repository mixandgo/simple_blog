require 'blog_markdown'

module BlogPostHelper
  include BlogMarkdown

  def blog_post_tags(post)
    raw post.tag_list.map { |tag| link_to(tag, filter_posts_path(tag)) }.join(", ")
  end

  def strip_tags_for_seo(text)
    strip_tags(text).strip
  end

  def languages_for_select
    ["en", "ro", "af", "ar", "az", "bg", "bn", "bs", "ca", "cs", "cy", "da", "de", "de-AT", "de-CH", "el", "en-AU", "en-CA", "en-GB", "en-IE", "en-IN", "en-NZ", "en-US", "en-ZA", "eo", "es", "es-419", "es-AR", "es-CL", "es-CO", "es-CR", "es-EC", "es-MX", "es-PA", "es-PE", "es-US", "es-VE", "et", "eu", "fa", "fi", "fr", "fr-CA", "fr-CH", "gl", "he", "hi", "hi-IN", "hr", "hu", "id", "is", "it", "it-CH", "ja", "km", "kn", "ko", "lo", "lt", "lv", "mk", "mn", "ms", "nb", "ne", "nl", "nn", "or", "pl", "pt", "pt-BR", "rm", "ru", "sk", "sl", "sr", "sv", "sw", "ta", "th", "tl", "tr", "uk", "ur", "uz", "vi", "wo", "zh-CN", "zh-HK", "zh-TW", "zh-YUE"]
  end

end
