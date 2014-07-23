require 'spec_helper'

feature 'Create posts' do
  scenario 'user can create new posts' do
    create_a_blog_post
    success_message = 'Post was succesfully updated.'
    expect(page).to have_content(success_message)
  end

  scenario 'titles have to be unique' do
    create_a_blog_post
    create_a_blog_post
    expect(page).to have_content('Post was not updated.')
    expect(page).to have_content("Title has already been taken")
  end

  scenario 'body and description have to be present' do
    create_a_blog_post(:body => '', :description => '')
    expect(page).to have_content('Post was not updated')
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'title and body have to be present on update of unpublished post' do
    create_a_blog_post(:title => '', :body => '', :unpublished => true)
    expect(page).to have_content('Post was not updated')
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'user can add tags' do
    create_a_blog_post(:tags => 'first_tag, second_tag')
    visit admin_blog_posts_path
    expect(page).to have_content('first_tag, second_tag')
  end

  scenario 'user can add keywords' do
    create_a_blog_post(:keywords => 'keyword1, keyword2')
    visit admin_blog_posts_path
    expect(page).to have_content('keyword1, keyword2')
  end

  scenario 'user can delete a post' do
    visit admin_blog_posts_path
    click_on 'New post'
    visit admin_blog_posts_path
    click_on 'Delete'
    expect(page).to have_content('Post was deleted succesfully')
    expect(page).to have_content('There are no published posts available.')
  end

  scenario 'user gets a warning when message is longer then 65 character', :js => true do
    visit new_admin_blog_post_path
    fill_in 'Title', :with => "a"*66
    expect(page).to have_content('Warning: Blog post title has over 65 characters')
  end

end
