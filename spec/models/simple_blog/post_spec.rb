require 'spec_helper'

module SimpleBlog
  describe Post do
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_most(72) }

    describe ".published" do
      it "finds all the published records" do
        published = FactoryGirl.create(:post)
        unpublished = FactoryGirl.create(:post, :published_at => nil)
        Post.published.should == [published]
      end
    end
  end
end
