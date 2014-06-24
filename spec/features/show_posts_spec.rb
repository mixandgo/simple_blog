require 'spec_helper'

feature 'Show posts' do
  background do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body', :tags => 'first_tag, second_tag')
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
    expect(current_url).to match(tag_path('first_tag'))
  end
end
