def create_a_blog_post(options={})
  visit new_admin_blog_post_path
  fill_in 'simple-blog-post-form-title', :with => options[:title] || 'Cool stuff'
  fill_in 'simple-blog-post-form-body', :with => options[:body] || 'Cool body'
  fill_in 'simple-blog-post-form-description', :with => options[:description] || 'Cool description'
  unless options.has_key?(:unpublished)
    select '1', :from => 'blog_post_published_at_3i'
    select 'January', :from => 'blog_post_published_at_2i'
    select '2013', :from => 'blog_post_published_at_1i'
  end
  fill_in 'simple-blog-post-form-tag-list', :with => options[:tags] || 'first_tag, second_tag'
  fill_in 'blog_post_keywords', :with => options[:keywords] || 'first_keyword, second_keyword'
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
