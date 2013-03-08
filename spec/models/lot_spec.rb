require 'spec_helper'

describe Lot do
  it "should let us make add a new one" do
    lot = FactoryGirl.create(:lot)
    lot.save.should be_true
  end
  it "should reject if lot_number is missing" do
    lot = build(:lot, lot_number: nil)
    lot.should_not be_valid
    lot.errors.full_messages.should include "Lot number can't be blank"
  end
  it "should reject if lot_number is duplicated" do
    lot = create(:lot)
    lot2 = build(:lot, lot_number: lot.lot_number)
    lot2.should_not be_valid
    lot2.errors.full_messages.should include "Lot number has already been taken"
  end
  it "should reject if item_master is missing" do
    lot = build(:lot, item_master_id: nil)
    lot.should_not be_valid
    lot.errors.full_messages.should include "Item master can't be blank"
  end
  it "should find the most recent sample for a test standard" do
    # Prepare
    test_suite = FactoryGirl.create(:test_suite_with_standards)
    item_master = FactoryGirl.create(:item_master, test_suite: test_suite)
    lot = FactoryGirl.create(:lot, item_master: item_master)
    a_standard = lot.item_master.test_suite.test_standards.last.standard
    lot_version = FactoryGirl.create(:lot_version, lot: lot)
    lot_version.prepare_samples!
    # Ensure clean test
    assert (lot.item_master.test_suite.test_standards.count > 1)
    assert_not_nil a_standard
    assert (lot_version.samples.count > 1)
    # Test
    sample = lot.last_sample(a_standard)
    sample.should_not be_nil
    sample.standard.should eq a_standard
    # Double check
    lot_version2 = FactoryGirl.create(:lot_version, lot: lot)
    lot_version2.prepare_samples!
    sample2 = lot.last_sample(a_standard)
    sample2.lot_version.should eq lot_version2
  end
end
