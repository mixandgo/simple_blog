def create_a_blog_post(options={})
  visit simple_blog.new_post_path
  fill_in 'Title', :with => options[:title] || 'My new post'
  fill_in 'Body', :with => options[:body] || 'The post body'
  click_button 'Create post'
end
