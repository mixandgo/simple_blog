def create_a_blog_post(options={})
  visit simple_blog.root_path
  click_link 'New post'
  fill_in 'Title', :with => options[:title] || 'My new post'
  fill_in 'Body', :with => options[:body] || 'The post body'
  click_button 'Create post'
end
