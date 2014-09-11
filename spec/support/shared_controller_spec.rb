require 'spec_helper'

shared_examples "a controller that needs @blog_post assigned" do |action|
  describe "making sure @blog_post gets assigned" do
    let(:blog_post) { double.as_null_object }
    let(:blog_post_id) { "100" }

    before :each do
      allow(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
    end

    it "calls unscoped_find_by with the blog_post_id" do
      expect(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id)
      xhr action[:method], action[:controller], action[:options].merge(:blog_post_id => blog_post_id)
    end

    it "assigns to @blog_post" do
      xhr action[:method], action[:controller], action[:options].merge(:blog_post_id => blog_post_id)
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end
end

