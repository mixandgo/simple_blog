require 'spec_helper'

describe BlogPostPresenter do
  let(:blog) { BlogPost.new(:title => "some title") }
  let!(:decorator) { BlogPostPresenter.new(blog) }

  before :each do
    allow(decorator).to receive(:root_url).and_return("http://mydomain.com")
  end

  describe "#seo_tags" do
    it "returns a description meta tag" do
      expect(decorator.seo_tags()).
        to match(%Q{<meta name="description" content="#{blog.description}"/>})
    end

    it "returns a keywords meta tag" do
      expect(decorator.seo_tags()).
        to match(%Q{<meta name="keywords" content="#{blog.keyword_list}"/>})
    end
  end

  describe "#twitter_card" do
    let(:twitter_site_name) { "@some_name" }
    let(:image) { double(:url => "/image_url.png") }

    before :each do
      allow(SimpleBlog).to receive(:twitter_site_name).and_return twitter_site_name
      allow(image).to receive(:image).and_return image
      allow(blog).to receive(:images).and_return [image]
    end

    it "returns the twitter card summary meta tag" do
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:card" content="summary_large_image"/>})
    end

    it "returns the twitter card title meta tag" do
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:title" content="#{blog.pretty_title}"/>})
    end

    it "retuns the twitter card description meta tag" do
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:description" content="#{blog.description}"/>})
    end

    it "returns the twitter card url meta tag" do
      expected_path = blog_post_url(blog)
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:url" content="#{expected_path}"/>})
    end

    it "returns the twitter site meta tag" do
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:site" content="#{twitter_site_name}"/>})
    end

    it "returns the twitter image meta tag" do
      expect(decorator.twitter_card()).
        to match(%Q{<meta name="twitter:image:src" content="http://mydomain.com#{image.url}"/>})
    end
  end

  describe "#facebook_card" do
    let(:fb_app_id) { "1234567890" }
    let(:image) { double(:url => "/image_url.png") }

    before :each do
      allow(SimpleBlog).to receive(:fb_app_id).and_return fb_app_id
      allow(image).to receive(:image).and_return image
      allow(blog).to receive(:images).and_return [image]
    end

    it "returns the open graph type meta tag" do
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="og:type" content="article"/>})
    end

    it "returns the open graph title meta tag" do
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="og:title" content="#{blog.pretty_title}"/>})
    end

    it "retuns the open graph description meta tag" do
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="og:description" content="#{blog.description}"/>})
    end

    it "returns the open graph url meta tag" do
      expected_path = blog_post_url(blog)
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="og:url" content="#{expected_path}"/>})
    end

    it "returns the facebook app id meta tag" do
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="fb:app_id" content="#{fb_app_id}"/>})
    end

    it "returns the open graph image meta tag" do
      expect(decorator.facebook_card()).
        to match(%Q{<meta property="og:image" content="http://mydomain.com#{image.url}"/>})
    end
  end

  describe "#set_meta_tags" do
    before :each do
      allow(decorator).to receive(:seo_tags).and_return ""
      allow(decorator).to receive(:twitter_card).and_return ""
      allow(decorator).to receive(:facebook_card).and_return ""
    end

    it "sets the seo_tags" do
      expect(decorator).to receive(:seo_tags)
      decorator.set_meta_tags
    end

    it "sets the twitter card" do
      expect(decorator).to receive(:twitter_card)
      decorator.set_meta_tags
    end

    it "sets the facebook card" do
      expect(decorator).to receive(:facebook_card)
      decorator.set_meta_tags
    end
  end

end
