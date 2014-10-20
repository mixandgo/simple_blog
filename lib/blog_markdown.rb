require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module BlogMarkdown
  include Redcarpet

  class Renderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown_body(body)
    markdown_renderer.render(body)
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
       underline: true,
       highlight: true,
       quoate: true,
       footnotes: true }
    end
end
