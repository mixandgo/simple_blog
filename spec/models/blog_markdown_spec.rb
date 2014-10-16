require 'spec_helper'

describe BlogMarkdown, :type => :model do

  describe "#markdown_body" do
    let(:blog_post) { build(:blog_post) }
    let(:markdown_renderer) { double.as_null_object }

    before :each do
      allow(blog_post).to receive(:markdown_renderer).and_return markdown_renderer
    end

    it "calls the markdown renderer" do
      expect(blog_post).to receive(:markdown_renderer)
      blog_post.markdown_body
    end

    it "renders the body from markdown" do
      expect(markdown_renderer).to receive(:render).with(blog_post.body)
      blog_post.markdown_body
    end
  end

end
