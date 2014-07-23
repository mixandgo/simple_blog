require 'spec_helper'

describe Imageable do
  it { should belong_to(:imageable) }
  it { should belong_to(:images) }
end
