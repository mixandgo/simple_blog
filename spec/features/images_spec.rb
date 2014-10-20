require 'spec_helper'

feature 'Images' do
  scenario 'user can add a image to the blog post' do
    create_a_blog_post(:title => "Blog Post Title", :image => "test.png")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    expect(page).to have_content("/uploads/blog_image/image/1/test.png")
    expect(page).to have_xpath("//img[@src=\"/uploads/blog_image/image/1/thumb_test.png\"]")
  end

  scenario 'user can add a image to an existing blog post' do
    create_a_blog_post(:title => "Blog Post Title")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    attach_image('simple-blog-post-form-image', 'test.png')
    click_on "Update post"
    click_on "Blog Post Title"
    expect(page).to have_content("/uploads/blog_image/image/1/test.png")
    expect(page).to have_xpath("//img[@src=\"/uploads/blog_image/image/1/thumb_test.png\"]")
  end

  scenario 'user can add multiple images when editing a blog post' do
    create_a_blog_post(:title => "Blog Post Title", :image => "test.png")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    attach_image('simple-blog-post-form-image', 'second_test.png')
    click_on "Update post"
    click_on "Blog Post Title"
    expect(page).to have_content("/uploads/blog_image/image/2/second_test.png")
  end

  scenario 'deleting existing image' do
    create_a_blog_post(:title => "Blog Post Title", :image => "test.png")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    click_on "Delete image"
    expect(page).to have_content("Blog image was deleted succesfully.")
    expect(page).to_not have_content("/uploads/blog_image/image/1/test.png")
  end

  scenario "user can only delete an image if he clicks 'Yes' inside the popup", :js => true do
    create_a_blog_post(:title => "Blog Post Title", :image => "test.png")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    click_on "Delete image"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content("Blog image was deleted succesfully.")
    expect(page).to_not have_content("/uploads/blog_image/image/1/test.png")
  end

  scenario "image will not be removed if the user clicks 'No' inside the popup", :js => true do
    create_a_blog_post(:title => "Blog Post Title", :image => "test.png")
    visit admin_blog_posts_path
    click_on "Blog Post Title"
    click_on "Delete image"
    page.driver.browser.switch_to.alert.dismiss
    expect(page).to_not have_content("Blog image was deleted succesfully.")
    expect(page).to have_content("/uploads/blog_image/image/1/test.png")
  end
end
