require 'spec_helper'

feature 'List posts' do
  background do
    create_a_blog_post(:title => 'Cool stuff', :body => 'Cool body', :tags => 'tag')
    create_a_blog_post(:title => 'More cool stuff', :body => 'Cool body', :tags => 'tag')
  end

  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'Unpublished post', :body => 'Cool body', :unpublished => true)
    visit blog_posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Unpublished Post')
  end

  scenario "posts show tags on index page" do
    visit blog_posts_path
    expect(page).to have_content("tag")
  end

  scenario "filtering by tag returns only posts with that tag" do
    create_a_blog_post(:title => 'post with different tag', :body => 'cool body', :tags => 'different tag')
    visit blog_posts_path
    click_link("tag", :match => :first)
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Post With Different Tag')
  end
end
