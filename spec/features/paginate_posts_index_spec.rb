require 'spec_helper'

describe 'Paginate posts index' do
  subject { page }
  describe 'index is paginated' do
    before do
      25.times { FactoryGirl.create(:blog_post) }
      visit blog_posts_path
    end
      BlogPost.page(1).each do |post|
        expect(page).to have_text('page')
      end
  end
end
