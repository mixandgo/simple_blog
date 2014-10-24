require 'spec_helper'

feature 'Edit posts' do
  scenario 'editing a blog post keeps you on the edit page' do
    create_a_blog_post
    click_on 'Update post'
    expect(current_path).to match "edit"
  end

  scenario 'editting a post' do
    create_a_blog_post(:title => 'Blog Post Title')
    fill_in 'simple-blog-post-form-title', :with => 'Different Blog Post Title'
    click_on 'Update post'
    expect(page).to have_content('Different Blog Post Title')
    expect(page).to have_content('Post was succesfully updated.')
  end

  scenario 'handle validations' do
    create_a_blog_post(:title => 'Blog Post Title')
    invalid_title = "a" * 80 # triggers a validation error
    invalid_body = invalid_description = ""
    fill_in 'simple-blog-post-form-title', :with => invalid_title
    add_text_to('body', invalid_body)
    add_text_to('description', invalid_description)
    click_on 'Update post'
    expect(page).to have_content('Post was not updated.')
    expect(page).to have_content('Title is too long')
    expect(page).to have_content("Body can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'update tags' do
    create_a_blog_post(:title => 'Blog Post Title')
    fill_in 'simple-blog-post-form-tag-list', :with => 'Edited_tag'
    click_on 'Update post'
    visit admin_blog_posts_path
    expect(page).to have_content('Edited_tag')
  end

  scenario 'update keywords' do
    create_a_blog_post(:title => 'Blog Post Title')
    fill_in 'simple-blog-post-form-keyword-list', :with => 'edited_keyword1, edited_keyword2'
    click_on 'Update post'
    visit admin_blog_posts_path
    expect(page).to have_content('edited_keyword1, edited_keyword2')
  end

  scenario 'deleting a post' do
    create_a_blog_post(:title => 'Blog Post Title')
    click_on 'Delete post'
    expect(page).to have_content('Post was deleted succesfully')
    expect(page).to have_content('There are no published posts available.')
  end

  scenario 'previewing a blog_post' do
    create_a_blog_post(:title => 'Blog Post Title', :unpublished => true)
    expect(page).to have_link("Preview: Blog Post Title", :href => "/blog/blog-post-title")
  end

  scenario 'clicking on the preview link will show me the blog post' do
    create_a_blog_post(:title => 'Blog Post Title', :unpublished => true)
    click_on 'Preview: Blog Post Title'
    expect(page).to have_content('Blog Post Title')
  end
end
