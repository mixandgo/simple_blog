require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'redcarpet_image'

module BlogMarkdown
  include Redcarpet

  class Renderer < RedcarpetImage
    include Rouge::Plugins::Redcarpet
  end

  def markdown_to_html(body)
    markdown_renderer.render(body).html_safe
  end

  private

    def markdown_renderer
      Redcarpet::Markdown.new(Renderer, markdown_extensions)
    end

    def markdown_extensions
      { no_intra_emphasis: true,
       autolink: true,
       fenced_code_blocks: true,
       strikethrough: true,
       disable_indented_code_blocks: true,
       lax_spacing: true,
       space_after_headers: true,
       superscript: true,
       underline: true,
       highlight: true,
       quoate: true,
       footnotes: true }
    end
end
