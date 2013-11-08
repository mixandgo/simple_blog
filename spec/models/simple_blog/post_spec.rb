require 'spec_helper'

module SimpleBlog
  describe Post do
    it { should validate_presence_of(:title) }
    it { should ensure_length_of(:title).is_at_most(72) }
  end
end
