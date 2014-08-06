require 'spec_helper'

describe Admin::Ckeditor::BlogPostImagesController do

  let(:blog_post) { double("blog_post") }
  let(:blog_post_id) { "100" }

  before :each do
    allow(BlogPost).to receive(:unscoped_find_by!).with(blog_post_id).and_return blog_post
  end

  let(:model) { blog_post }

  it_behaves_like "an image post controller", {:blog_post_id => 100}

end
