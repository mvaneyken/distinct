require 'spec_helper'

describe ItemMaster do
  it "should let us make add a new one" do
    item_master = FactoryGirl.create(:item_master)
    item_master.save.should be_true
  end
  it "should require an code" do
    item_master = FactoryGirl.build(:item_master, code: nil)
    item_master.should_not be_valid
    item_master.errors.full_messages.should include "Code can't be blank"
  end
  it "should require an description" do
    item_master = FactoryGirl.build(:item_master, description: nil)
    item_master.should_not be_valid
    item_master.errors.full_messages.should include "Description can't be blank"
  end
  it "may have a test suite with standards" do
    item_master = FactoryGirl.build(:item_master_with_test_suite)
    item_master.should be_valid
    assert_not_nil item_master.test_suite
    item_master.test_suite.test_standards.count.should_not eq(0)
  end
end
