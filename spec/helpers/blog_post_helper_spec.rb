require 'spec_helper'

RSpec.describe BlogPostHelper, :type => :helper do
  describe "link_to_with_analytics" do
    let(:date) { Time.local(2015, 02, 05, 12, 0, 0) }
    let(:blog_post) { build(:blog_post, :title => "Blog Post Title", :published_at => date) }

    it "returns an empty string if blog post is unpublished" do
      allow(blog_post).to receive(:published?).and_return(false)
      expect(helper.link_to_with_analytics(blog_post, "", "")).to eq("")
    end

    it "returns a link with the ga params if blog post is published" do
      allow(blog_post).to receive(:published?).and_return(true)
      expect(helper.link_to_with_analytics(blog_post, "facebook", "direct_facebook")).
        to have_link("Facebook", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_05_02_2015&utm_medium=direct_facebook&utm_source=facebook")
    end

  end
end
