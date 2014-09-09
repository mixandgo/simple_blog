def create_a_blog_post(options={})
  visit new_admin_blog_post_path
  fill_in 'simple-blog-post-form-title', :with => options[:title] || 'Blog Post Title'
  fill_in 'simple-blog-post-form-body', :with => options[:body] || 'Blog Post Body'
  fill_in 'simple-blog-post-form-description', :with => options[:description] || 'Blog Post Description'
  unless options.has_key?(:unpublished)
    select '1', :from => 'blog_post_published_at_3i'
    select 'January', :from => 'blog_post_published_at_2i'
    select '2013', :from => 'blog_post_published_at_1i'
  end
  fill_in 'simple-blog-post-form-tag-list', :with => options[:tags] || 'first_tag, second_tag'
  fill_in 'simple-blog-post-form-keyword-list', :with => options[:keywords] || 'first_keyword, second_keyword'
  click_button 'Update post'
end

def method_missing(meth, *args, &block)
  if meth.to_s =~ /^create_a_blog_post_with_(.+)$/
    options = {$1.to_sym => args.first}
    create_a_blog_post(options, &block)
  else
    super
  end
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

def create_a_blog_post_and_go_to_it
  create_a_blog_post_with_title('Blog Post Title')
  visit admin_blog_posts_path
  click_on 'Blog Post Title'
end
