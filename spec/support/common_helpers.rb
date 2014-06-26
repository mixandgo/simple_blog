def create_a_blog_post(options={})
  visit new_admin_blog_post_path
  fill_in 'Title', :with => options[:title] || 'My new post'
  fill_in 'simple-blog-post-form-body', :with => options[:body] || 'The post body'
  fill_in 'simple-blog-post-form-description', :with => options[:description] || 'The post description'
  unless options.has_key?(:unpublished)
    select '1', :from => 'blog_post_published_at_3i'
    select 'January', :from => 'blog_post_published_at_2i'
    select '2013', :from => 'blog_post_published_at_1i'
  end
  fill_in 'blog_post_tag_list', :with => options[:tags] || 'tag1, tag2'
  fill_in 'blog_post_keywords', :with => options[:keywords] || 'keyword1, keyword2'
  click_button 'Create post'
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
