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

    describe "#to_param" do
      it "returns the name converted to a slug" do
        post = FactoryGirl.build(:post, :title => "A cool title")
        expect(post.to_param).to eq("a-cool-title")
      end
    end
  end
end
