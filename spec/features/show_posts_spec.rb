require 'spec_helper'

feature 'Show posts' do
  scenario 'displaying a post' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body', :tags => 'first_tag, second_tag')
    visit blog_posts_path
    click_on 'Cool Stuff'
    expect(page).to have_content('Cool Stuff') # yes, it's titleized
    expect(page).to have_content('Cool body')
    expect(page).to have_content('first_tag, second_tag')
  end
end

