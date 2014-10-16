require 'spec_helper'

describe BlogImage, :type => :model do
  it { is_expected.to belong_to(:blog_post) }
end
