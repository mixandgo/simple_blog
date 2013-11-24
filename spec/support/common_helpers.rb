def create_a_blog_post(options={})
  visit new_admin_blog_post_path
  fill_in 'Title', :with => options[:title] || 'My new post'
  fill_in 'Body', :with => options[:body] || 'The post body'
  unless options.has_key?(:unpublished)
    select '1', :from => 'blog_post_published_at_3i'
    select 'January', :from => 'blog_post_published_at_2i'
    select '2013', :from => 'blog_post_published_at_1i'
  end
  click_button 'Create post'
end
