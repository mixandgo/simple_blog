require 'spec_helper'

feature 'Images' do

  scenario 'adding an image to a new blog_post', :js => true do
    open_ckeditor_browser
    inside_ckeditor_browser do
      upload_image('logo.png')
      expect(page).to have_xpath("//img[@title='logo.png']")
    end
  end

  scenario 'adding and image to a new blog_post does not add it to another new blog_post', :js => true do
    open_ckeditor_browser
    inside_ckeditor_browser do
      upload_image('logo.png')
    end
    visit admin_blog_posts_path
    open_ckeditor_browser
    inside_ckeditor_browser do
      expect(page).to_not have_xpath("//img[@title='logo.png']")
    end
  end

  scenario 'deleting an image', :js => true do
    open_ckeditor_browser
    inside_ckeditor_browser do
      upload_image('logo.png')
      delete_image('logo.png')
      expect(page).to_not have_xpath("//img[@title='logo.png']")
    end
  end

end
