require 'spec_helper'

describe TestSuite do
  it "should let us make add a new one" do
    test_suite = FactoryGirl.create(:test_suite)
    test_suite.save.should be_true
  end
  it "should require an name" do
    test_suite = FactoryGirl.build(:test_suite, name: nil)
    test_suite.should_not be_valid
    test_suite.errors.full_messages.should include "Name can't be blank"
  end
  it "may have standards" do
    test_suite = FactoryGirl.create(:test_suite_with_standards)
    test_suite.test_standards.count.should be > 0
  end
end
