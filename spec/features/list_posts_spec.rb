require 'spec_helper'

feature 'List posts' do
  background do
    create_a_blog_post
  end

  scenario 'should display description' do
    visit blog_posts_path
    expect(page).to have_content('Cool description')
    expect(page).not_to have_content('Cool body')
  end

  scenario 'all the published posts are displayed' do
    create_a_blog_post(:title => 'More cool stuff')
    create_a_blog_post(:title => 'Unpublished post', :unpublished => true)
    visit blog_posts_path
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Unpublished Post')
  end

  scenario 'posts show tags on index page' do
    visit blog_posts_path
    expect(page).to have_content('first_tag')
  end

  scenario 'filtering by tag returns only posts with that tag' do
    create_a_blog_post(:title => 'More cool stuff')
    create_a_blog_post(:title => 'Not cool stuff', :tags => 'different tag')
    visit blog_posts_path
    click_link('first_tag', :match => :first)
    expect(page).to have_content('Cool Stuff')
    expect(page).to have_content('More Cool Stuff')
    expect(page).not_to have_content('Not Cool Stuff')
  end
end
