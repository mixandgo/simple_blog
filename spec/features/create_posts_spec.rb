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

  scenario 'user can add tags' do
    create_a_blog_post(:tags => 'first_tag, second_tag')
    visit admin_blog_posts_path
    expect(page).to have_content('Tags: first_tag, second_tag')
  end

  scenario 'user can add keywords' do
    create_a_blog_post(:keywords => 'keyword1, keyword2')
    visit admin_blog_posts_path
    expect(page).to have_content('Keywords: keyword1, keyword2')
  end
end
