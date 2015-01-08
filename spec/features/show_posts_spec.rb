require 'spec_helper'

feature 'Show posts' do
  background do
    create_a_blog_post(:title => 'Blog post title',
                       :body => 'Blog post body',
                       :tags => 'first_tag second_tag',
                       :description => 'Blog post description',
                       :keywords => 'first_keyword, second_keyword')
    visit_show_page_for('Blog Post Title')
  end

  scenario 'displaying a post' do
    expect(page).to have_content('Blog Post Title') # yes, it's titleized
    expect(page).to have_content('Blog post body')
    expect(page).to have_content('first_tag, second_tag')
  end

  scenario 'clicking on a tag adds the tag as a filter in the url' do
    click_on 'first_tag'
    expect(current_url).to match(filter_posts_path('first_tag'))
  end
end
