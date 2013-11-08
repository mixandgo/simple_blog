require 'spec_helper'

feature 'Show posts' do
  scenario 'displaying a post' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    visit simple_blog.posts_path
    click_on 'Cool Stuff'
    expect(page).to have_content('Cool Stuff') # yes, it's titleized
    expect(page).to have_content('Cool body')
  end
end

