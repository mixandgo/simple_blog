require 'spec_helper'

feature "Google Analytics Tagging" do
  scenario 'Admin sees default tagged links' do
    Capybara.default_host = "http://test.host"
    create_a_blog_post(:title => "Blog Post Title", :published_at => "02/05/2015")
    expect(page).to have_link("Newsletter", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=email&utm_source=newsletter")
    expect(page).to have_link("Facebook", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=direct_facebook&utm_source=facebook")
    expect(page).to have_link("Twitter", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=direct_twitter&utm_source=twitter")
    expect(page).to have_link("Google Plus", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=direct_google_plus&utm_source=google_plus")
    expect(page).to have_link("Reddit", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=direct_reddit&utm_source=reddit")
    expect(page).to have_link("Ruby5", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=backlink&utm_source=ruby5")
    expect(page).to have_link("Ruby Weekly", :href => "http://test.host/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=backlink&utm_source=ruby_weekly")
  end

  scenario 'Admin can create a new custom link', :js => true do
    create_a_blog_post(:title => "Blog Post Title", :published_at => "02/05/2015")
    fill_in 'simple-blog-post-form-custom-source', :with => 'hacker_newsletter'
    fill_in 'simple-blog-post-form-custom-medium', :with => 'backlink'
    click_button 'Create Custom GA Link'
    expect(page).to have_xpath('//a[contains(@href, "/blog/blog-post-title?utm_campaign=blog_post_02_05_2015&utm_medium=backlink&utm_source=hacker_newsletter")]')
  end
end
