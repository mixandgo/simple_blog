require 'spec_helper'

feature 'Social sharing and seo' do

  background do
    create_a_blog_post(:title => 'Blog post title',
                       :body => 'Blog post body',
                       :description => 'Blog post description',
                       :keywords => 'first_keyword, second_keyword',
                       :image => "test.png")
  end

  context 'show page' do

    background do
      visit_show_page_for('Blog Post Title')
    end

    scenario 'should have keyword and description meta tags' do
      expect_page_to_contain_meta_tag("description", "Blog post description")
      expect_page_to_contain_meta_tag("keywords", "first_keyword, second_keyword")
    end

    scenario 'should have sherable buttons' do
      expect(page).to have_css(".social-share-button-twitter")
      expect(page).to have_css(".social-share-button-facebook")
      expect(page).to have_css(".social-share-button-google_plus")
    end

    scenario 'should have open graph meta tags' do
      expect(page).to have_css("meta[property='og:title'][content='Blog Post Title']", :visible => false)
      expect(page).to have_css("meta[property='og:type'][content='article']", :visible => false)
      expect(page).to have_css("meta[property='og:url'][content='/blog/blog-post-title']", :visible => false)
      expect(page).to have_css("meta[property='og:description'][content='Blog post description']", :visible => false)
      expect(page).to have_css("meta[property='og:image'][content='/uploads/blog_image/image/1/test.png']", :visible => false)
      expect(page).to have_css("meta[property='fb:app_id'][content='[FB_APP_ID]']", :visible => false)
    end

    scenario 'should have twitter meta tags' do
      expect(page).to have_css("meta[name='twitter:card'][content='summary']", :visible => false)
      expect(page).to have_css("meta[name='twitter:site'][content='[@your_website]']", :visible => false)
      expect(page).to have_css("meta[name='twitter:title'][content='Blog Post Title']", :visible => false)
      expect(page).to have_css("meta[name='twitter:description'][content='Blog post description']", :visible => false)
      expect(page).to have_css("meta[name='twitter:url'][content='/blog/blog-post-title']", :visible => false)
      expect(page).to have_css("meta[name='twitter:image'][content='/uploads/blog_image/image/1/test.png']", :visible => false)
    end

    scenario 'should have schema.org microdata' do
      expect(page).to have_css("div[itemtype='http://schema.org/Article']")
      expect(page).to have_css("h1[itemprop='name']")
      expect(page).to have_css("p[itemprop='keywords']")
      expect(page).to have_css("div[itemprop='articleBody']")
    end

  end

  context 'index page' do

    background do
      visit blog_posts_path
    end

    scenario 'sould have sherable buttons' do
      expect(page).to have_css(".social-share-button-twitter")
      expect(page).to have_css(".social-share-button-facebook")
      expect(page).to have_css(".social-share-button-google_plus")
    end

    scenario 'should have schema.org microdata' do
      expect(page).to have_css("div[itemtype='http://schema.org/Article']")
      expect(page).to have_css("h2[itemprop='name']")
      expect(page).to have_css("div[itemprop='keywords']")
      expect(page).to have_css("p[itemprop='description']")
    end

  end

end
