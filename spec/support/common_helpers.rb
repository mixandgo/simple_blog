def create_a_blog_post(options={})
  visit new_admin_blog_post_path
  fill_in 'simple-blog-post-form-title', :with => options[:title] || 'Blog Post Title'
  fill_in 'simple-blog-post-form-body', :with => options[:body] || 'Blog Post Body'
  fill_in 'simple-blog-post-form-description', :with => options[:description] || 'Blog Post Description'
  unless options.has_key?(:unpublished)
    fill_in 'simple-blog-post-form-published-at', :with => '01/01/2014'
  end
  fill_in 'simple-blog-post-form-tag-list', :with => options[:tags] || 'first_tag, second_tag'
  fill_in 'simple-blog-post-form-keyword-list', :with => options[:keywords] || 'first_keyword, second_keyword'
  click_button 'Update post'
end

def add_text_to(textarea, text)
  fill_in "simple-blog-post-form-#{textarea}", :with => text
end

def expect_url_to_contain(string)
  expect(URI.parse(current_url).to_s).to match(string)
end

def expect_url_not_to_contain(string)
  expect(URI.parse(current_url).to_s).not_to match(string)
end

def expect_page_to_contain_meta_tag(name, content)
  expect(page).to have_css("meta[name='#{name}'][content='#{content}']", :visible => false)
end


def visit_admin_edit_page_for(title)
  visit admin_blog_posts_path
  click_on title
end

def visit_show_page_for(title)
  visit blog_posts_path
  click_on title
end

# Used to fill ckeditor fields
# @param [String] locator label text for the textarea or textarea id
def fill_in_ckeditor(locator, params = {})
  page.execute_script <<-SCRIPT
  var ckeditor = CKEDITOR.instances['#{locator}']
  ckeditor.setData('#{params[:with]}');
  ckeditor.document.fire("keyup");
  SCRIPT
end

def wait_for_ckeditor(selector)
  expect(page).to have_css(selector)
end
