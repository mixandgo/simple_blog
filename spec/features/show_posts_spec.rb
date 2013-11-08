require 'spec_helper'

feature 'Show posts' do
  scenario 'displaying a post' do
    create_a_blog_post('Cool stuff')
    visit simple_blog.posts_path
  end
end

