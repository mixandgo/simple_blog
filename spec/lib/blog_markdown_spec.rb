require 'spec_helper'
require 'blog_markdown'

describe BlogMarkdown, :type => :model do

  let(:body) { "Some text" }

  class BlogModel
    include BlogMarkdown
  end

  before :each do
    @blog_model = BlogModel.new
  end

  describe "#markdown_to_html" do
    let(:markdown_renderer) { double.as_null_object }
    let(:markdown_body) { double.as_null_object }

    before :each do
      allow(@blog_model).to receive(:markdown_renderer).and_return markdown_renderer
      allow(markdown_renderer).to receive(:render).and_return markdown_body
    end

    it "calls the markdown renderer" do
      expect(@blog_model).to receive(:markdown_renderer)
      @blog_model.markdown_to_html(body)
    end

    it "converts markdown to html" do
      expect(markdown_renderer).to receive(:render).with(body)
      @blog_model.markdown_to_html(body)
    end

    it "sets the markdown body to html_safe" do
      expect(markdown_body).to receive(:html_safe)
      @blog_model.markdown_to_html(body)
    end
  end

  describe "Redcarpet::Markdown" do
    before :each do
      allow(::Redcarpet::Markdown).to receive(:new).with(any_args).and_return double.as_null_object
    end

    it "instantiates a Redcarpet::Markdown with the appropiate extensions" do
      expected_extensions = { no_intra_emphasis: true,
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

      expect(::Redcarpet::Markdown).to receive(:new).with(anything, expected_extensions)
      @blog_model.markdown_to_html(body)
    end
    
    it "instantiates a Redcarpet::Markdown with the BlogMarkdown::Renderer class" do
      expect(::Redcarpet::Markdown).to receive(:new).with(BlogMarkdown::Renderer, anything)
      @blog_model.markdown_to_html(body)
    end
  end
end
