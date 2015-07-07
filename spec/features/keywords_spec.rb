require 'spec_helper'

feature 'Keyword Parser' do

  background do
    pending "Keyword don't really work. Set this to pending until we have time for a proper fix."
    visit new_admin_blog_post_path
  end

  scenario 'user sees the top keywords while writing an article', :js => true do
    fill_in_body_with "coolbody "*6
    click_on "Create post"
    expect(page).to have_content('Keyword: "coolbody" Count: 6')
  end

  scenario 'user does not see whitespaces as top keywords when writing an article', :js => true do
    fill_in_body_with "coolbody                        "*6
    click_on "Create post"
    expect(page).to have_content('Keyword: "coolbody" Count: 6')
  end

  scenario 'keyword parser should ignore case when counting keywords', :js => true do
    fill_in_body_with "coolbody Coolbody cOOlbody cooLBody COOLBODY coolboDY"
    click_on "Create post"
    expect(page).to have_content('Keyword: "coolbody" Count: 6')
  end

  scenario 'keyword parser should ignore words smaller then 2', :js => true do
    fill_in_body_with "co co awesome co"
    click_on "Create post"
    expect(page).to have_content('Keyword: "awesome" Count: 1')
    expect(page).to_not have_content('Keyword: "co" Count: 3')
  end

  scenario 'keyword parser should ignore usual words', :js => true do
    fill_in_body_with "the what their awesome"
    click_on "Create post"
    expect(page).to have_content('Keyword: "awesome" Count: 1')
    expect(page).to_not have_content('Keyword: "the" Count: 1')
    expect(page).to_not have_content('Keyword: "what" Count: 1')
    expect(page).to_not have_content('Keyword: "their" Count: 1')
  end

end
