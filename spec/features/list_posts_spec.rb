require 'spec_helper'

feature 'List posts' do
  scenario 'displaying the posts list' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'More cool stuff', :body => 'Cool body')
    visit simple_blog.posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
  end
end


