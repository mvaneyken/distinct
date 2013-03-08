require 'spec_helper'

describe TestStandard do
  it "should let us make add a new one" do
    test_standard = FactoryGirl.create(:test_standard)
    test_standard.save.should be_true
  end
end
