require 'spec_helper'

feature 'List posts' do
  background do
    create_a_blog_post(:title => 'Blog post title',
                       :body => 'Blog post body',
                       :tags => 'first_tag, second_tag',
                       :description => 'Blog post description',
                       :keywords => 'first_keyword, second_keyword')
  end

  scenario "should only display the post's descsription" do
    visit blog_posts_path
    expect(page).to have_content('Blog post description')
    expect(page).not_to have_content('Blog post body')
  end

  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'Unpublished post title', :unpublished => true)
    visit blog_posts_path
    expect(page).to have_content('Blog Post Title')
    expect(page).not_to have_content('Unpublished Post title')
  end

  scenario 'posts show tags on index page' do
    visit blog_posts_path
    expect(page).to have_content('first_tag')
  end

  scenario 'filtering by tag returns only posts with that tag' do
    create_a_blog_post(:title => 'Differnt tag blog post title', :tags => 'different tag')
    visit blog_posts_path
    click_link('first_tag', :match => :first)
    expect(page).to have_content('Blog Post Title')
    expect(page).not_to have_content('Different Tag Blog Post Title')
  end

  scenario "filtering by tag shouldn't filter by keyword" do
    create_a_blog_post(:title => 'Differnt tag blog post title', :keywords => 'first_tag')
    visit blog_posts_path
    click_link('first_tag', :match => :first)
    expect(page).to have_content('Blog Post Title')
    expect(page).not_to have_content('Different Tag Blog Post Title')
  end
end
