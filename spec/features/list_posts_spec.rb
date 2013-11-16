require 'spec_helper'

feature 'List posts' do
  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'More cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'Unpublished post', :body => 'Cool body', :unpublished => true)
    visit simple_blog.posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Unpublished Post')
  end

  scenario 'user can create new posts by clicking on a link' do
    visit simple_blog.posts_path
    click_on 'New post'
    expect(page.current_url).to eq(simple_blog.new_post_url)
  end
end
