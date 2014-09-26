require 'spec_helper'

describe Imageable, :type => :model do
  it { is_expected.to belong_to(:imageable) }
  it { is_expected.to belong_to(:images) }
end
