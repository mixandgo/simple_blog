require 'spec_helper'

describe 'Paginate posts index' do
  describe 'index is paginated' do
    before do
      POSTS_PER_PAGE = 25
      POSTS_PER_PAGE.times { create(:blog_post) }
      visit blog_posts_path
    end
      BlogPost.page(1).each do |post|
        expect(page).to have_text('page')
      end
  end
end
