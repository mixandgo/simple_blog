require 'spec_helper'

feature 'Show posts' do
  background do
    create_a_blog_post(:title => 'Cool stuff',
                       :body => 'Cool body',
                       :description => 'Cool description',
                       :tags => 'first_tag, second_tag',
                       :keywords => 'first_keyword, second_keyword')
    visit blog_posts_path
    click_on 'Cool Stuff'
  end

  scenario 'displaying a post' do
    expect(page).to have_content('Cool Stuff') # yes, it's titleized
    expect(page).to have_content('Cool body')
    expect(page).to have_content('first_tag, second_tag')
  end

  scenario 'clicking on a tag adds the tag as a filter in the url' do
    click_on 'first_tag'
    expect(current_url).to match(filter_posts_path('first_tag'))
  end

  scenario 'page should have meta tags for seo' do
    expect_page_to_contain_meta_tag("description", "Cool description")
    expect_page_to_contain_meta_tag("keywords", "first_keyword, second_keyword")
  end
end
