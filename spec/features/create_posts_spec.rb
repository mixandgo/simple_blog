require 'spec_helper'

feature 'Create posts' do
  scenario 'creating a blog post redirects you to the edit page' do
    create_a_blog_post
    expect(current_path).to match "edit"
  end

  scenario 'creating a blog with another language then english' do
    create_a_blog_post(:language => "ro")
    visit admin_blog_posts_path
    expect(page).to have_content("ro")
  end

  scenario 'user can create new posts' do
    create_a_blog_post
    success_message = 'Post was succesfully created.'
    expect(page).to have_content(success_message)
  end

  scenario 'titles have to be unique' do
    create_a_blog_post
    create_a_blog_post
    expect(page).to have_content('Post was not created.')
    expect(page).to have_content('Title has already been taken')
  end

  scenario 'body and description have to be present' do
    create_a_blog_post(:body => '', :description => '')
    expect(page).to have_content('Post was not created')
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'title and body have to be present on create of unpublished post' do
    create_a_blog_post(:title => '', :body => '', :unpublished => true)
    expect(page).to have_content('Post was not created')
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
    create_a_blog_post(:title => "Blog Post Title")
    visit admin_blog_posts_path
    click_on "Delete"
    expect(page).to have_content('Post was deleted succesfully')
    expect(page).to have_content('There are no published posts available.')
  end

  scenario 'user gets a warning when message is longer then 65 character', :js => true do
    visit new_admin_blog_post_path
    fill_in 'simple-blog-post-form-title', :with => "a"*66
    expect(page).to have_content('Warning: Blog post title has over 65 characters')
  end

  scenario 'user can set a published_at date that will stay' do
    create_a_blog_post(:title => "Blog Post Title", :published_at => "01/01/2014")
    expect(page).to have_xpath("//input[@value='01/01/2014']")
  end

  scenario "user won't see a preview link when creating a blog post" do
    visit new_admin_blog_post_path
    expect(page).to_not have_content("Preview: ")
  end
end
