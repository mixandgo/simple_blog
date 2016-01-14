require 'spec_helper'

describe 'Paginate posts index' do
  describe 'index is paginated' do
    before do
      POSTS_PER_PAGE = 25
      POSTS_PER_PAGE.times { create(:blog_post) }
      visit blog_posts_path
    end
      it "limits the number of posts to #{BlogPost::POSTS_PER_PAGE}" do
        expect(page).to have_selector('.blog-post', count: BlogPost::POSTS_PER_PAGE)
      end
  end
end
