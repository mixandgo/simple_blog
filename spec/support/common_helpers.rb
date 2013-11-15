def create_a_blog_post(options={})
  visit simple_blog.root_path
  click_link 'New post'
  fill_in 'Title', :with => options[:title] || 'My new post'
  fill_in 'Body', :with => options[:body] || 'The post body'
  unless options.has_key?(:unpublished)
    select '1', :from => 'post_published_at_3i'
    select 'January', :from => 'post_published_at_2i'
    select '2013', :from => 'post_published_at_1i'
  end
  click_button 'Create post'
end
