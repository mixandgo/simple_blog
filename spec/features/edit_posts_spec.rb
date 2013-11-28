require 'spec_helper'

feature 'Edit posts' do
  scenario 'editting a post' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    fill_in :blog_post_title, :with => "Uncool stuff"
    click_on 'Update post'
    expect(page).to have_content('Uncool Stuff')
    expect(page).to have_content('Post was succesfully updated.')
  end

  scenario 'handle validation' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    invalid_title = "a" * 80 # triggers a validation error
    fill_in :blog_post_title, :with => invalid_title
    click_on 'Update post'
    expect(page).to have_content('Post was not updated.')
  end
end
