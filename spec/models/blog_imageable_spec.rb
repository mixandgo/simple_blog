require 'spec_helper'

describe BlogImageable do
  it { should belong_to(:imageable) }
  it { should belong_to(:pictures) }
end
