class RedcarpetImage < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    %Q{<img src="#{link}" class="simple-blog-image" title="#{title}" alt="#{alt_text}" />}
  end
end
