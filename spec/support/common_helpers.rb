def create_a_blog_post(title=nil)
  visit simple_blog.new_post_path
  fill_in 'Title', :with => title || 'My new post'
  fill_in 'Body', :with => 'The post body'
  click_button 'Create post'
end
