require 'spec_helper'

describe SimpleBlog::ApplicationHelper do
  it "calls the main app's path helpers" do
    main_app = double("app", :random_path => "foo")
    helper.stub(:main_app).and_return(main_app)
    expect(helper.random_path).to eq("foo")
  end

  it "calls the main app's url helpers" do
    main_app = double("app", :random_url => "foo")
    helper.stub(:main_app).and_return(main_app)
    expect(helper.random_url).to eq("foo")
  end
end
