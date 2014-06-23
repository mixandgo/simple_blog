require 'spec_helper'

feature 'List posts' do
  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'More cool stuff', :body => 'Cool body')
    create_a_blog_post(:title => 'Unpublished post', :body => 'Cool body', :unpublished => true)
    visit blog_posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Unpublished Post')
  end

  scenario "posts show tags on index page" do
    create_a_blog_post(:tags => "first_tag, second_tag")
    visit blog_posts_path
    expect(page).to have_content("first_tag, second_tag")
  end

  scenario "filtering by tag returns only posts with that tag" do
    create_a_blog_post(:title => 'First post', :body => 'cool body', :tags => 'tag')
    create_a_blog_post(:title => 'Second post', :body => 'cool body', :tags => 'tag')
    create_a_blog_post(:title => 'post with different tag', :body => 'cool body', :tags => 'different tag')
    visit blog_posts_path
    click_link("tag", :match => :first)
    expect(page).to have_content('First Post')
    expect(page).to have_content('Second Post')
    expect(page).not_to have_content('post with different tag')
  end
end
