require 'spec_helper'

feature 'Keyword Parser' do

  background do
    visit new_admin_blog_post_path
  end

  scenario 'user sees the top keywords while writing an article', :js => true do
    fill_in_body_with "coolbody "*6
    click_on "Create post"
    expect(page).to have_content('kw: coolbody - nr: 6')
  end

  scenario 'user does not see whitespaces as top keywords when writing an article', :js => true do
    fill_in_body_with "coolbody                        "*6
    click_on "Create post"
    expect(page).to have_content('kw: coolbody - nr: 6')
  end

  scenario 'keyword parser should ignore case when counting keywords', :js => true do
    fill_in_body_with "coolbody Coolbody cOOlbody cooLBody COOLBODY coolboDY"
    click_on "Create post"
    expect(page).to have_content('kw: coolbody - nr: 6')
  end

  scenario 'keyword parser should ignore words smaller then 2', :js => true do
    fill_in_body_with "co co co"
    click_on "Create post"
    expect(page).to_not have_content('kw: co - nr: 3')
  end

  scenario 'keyword parser should ignore usual words', :js => true do
    fill_in_body_with "the what their"
    click_on "Create post"
    expect(page).to_not have_content('kw: the - nr: 1')
    expect(page).to_not have_content('kw: what - nr: 1')
    expect(page).to_not have_content('kw: their - nr: 1')
  end

end
