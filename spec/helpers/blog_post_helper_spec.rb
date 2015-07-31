require 'spec_helper'

RSpec.describe BlogPostHelper, :type => :helper do
  describe "blog_post_tags" do
    let(:blog_post) { build(:blog_post) }

    it "returns a link to the tag page" do
      blog_post.tag_list << "tag1"

      expected_link = '<a href="/blog/tag/tag1">tag1</a>'
      expect(helper.blog_post_tags(blog_post)).to eq(expected_link)
    end

    it "replaces spaces with dashes for tags with spaces" do
      blog_post.tag_list << "some tag"

      expected_link = '<a href="/blog/tag/some-tag">some tag</a>'
      expect(helper.blog_post_tags(blog_post)).to eq(expected_link)
    end
  end

  describe "blog_post_url_with_analytics" do
    let(:date) { Time.local(2015, 02, 05, 12, 0, 0) }
    let(:blog_post) { build(:blog_post, :title => "Blog Post Title", :published_at => date) }

    it "returns an empty string if blog post is unpublished" do
      allow(blog_post).to receive(:published?).and_return(false)
      expect(helper.blog_post_url_with_analytics(blog_post, "", "")).to eq("")
    end

    it "returns a link with the ga params if blog post is published" do
      allow(blog_post).to receive(:published?).and_return(true)
      expect(helper.blog_post_url_with_analytics(blog_post, "facebook", "direct_facebook")).
        to eq("http://test.host/blog/blog-post-title?utm_campaign=blog_post_05_02_2015&utm_medium=direct_facebook&utm_source=facebook")
    end

  end
end
