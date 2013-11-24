require 'spec_helper'

describe BlogTag do
  it { should have_many(:blog_posts) }
end
