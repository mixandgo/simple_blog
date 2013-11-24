require 'spec_helper'

feature 'List posts' do
  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'More cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'Unpublished post', :body => 'Cool body', :unpublished => true)
    visit blog_posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Unpublished Post')
  end
end
