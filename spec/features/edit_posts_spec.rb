require 'spec_helper'

feature 'Edit posts' do
  scenario 'editting a post' do
    create_a_blog_post
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    fill_in :blog_post_title, :with => "Uncool stuff"
    click_on 'Update post'
    expect(page).to have_content('Uncool Stuff')
    expect(page).to have_content('Post was succesfully updated.')
  end

  scenario 'handle validations' do
    create_a_blog_post
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    invalid_title = "a" * 80 # triggers a validation error
    invalid_body = invalid_description = ""
    fill_in :blog_post_title, :with => invalid_title
    add_text_to('body', invalid_body)
    add_text_to('description', invalid_description)
    click_on 'Update post'
    expect(page).to have_content('Post was not updated.')
    expect(page).to have_content('Title is too long')
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'update tags' do
    create_a_blog_post
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    fill_in 'blog_post_tag_list', :with => 'Edited_tag'
    click_on 'Update post'
    visit admin_blog_posts_path
    expect(page).to have_content('Tags: Edited_tag')
  end

  scenario 'update keywords' do
    create_a_blog_post
    visit admin_blog_posts_path
    click_on 'Cool Stuff'
    fill_in 'blog_post_keywords', :with => 'edited_keyword1, edited_keyword2'
    click_on 'Update post'
    visit admin_blog_posts_path
    expect(page).to have_content('Keywords: edited_keyword1, edited_keyword2')
  end

  scenario 'deleting a post' do
    visit admin_blog_posts_path
    click_on 'New post'
    click_on 'Delete post'
    expect(page).to have_content('Post was deleted succesfully')
    expect(page).to have_content('There are no published posts available.')
  end
end
