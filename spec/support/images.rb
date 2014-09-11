def open_ckeditor_browser
  visit new_admin_blog_post_path
  find(:css, "div#cke_simple-blog-post-form-description")
  find(:css, "a#cke_33").click
  find(:css, "a#cke_105_uiElement").click
end

def inside_ckeditor_browser
  new_window = page.driver.browser.window_handles.last
  page.within_window new_window do
    yield
  end
end

def upload_image(image)
  click_on "Upload"
  attach_image(image)
end

def delete_image(image)
  find(:css, "a.gal-del").click
  page.driver.browser.switch_to.alert.accept
end

def attach_image(image)
  attach_file("file", File.expand_path(File.join("spec", "fixtures", "blog_post", image)), :visible => false)
end

