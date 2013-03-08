require 'spec_helper'

describe LotVersion do
  it "should let us make add a new one" do
    lot_version = FactoryGirl.create(:lot_version)
    lot_version.save.should be_true
  end
  it "should be incrementaly numbered" do
    lot = FactoryGirl.create(:lot)
    3.times do 
      lot_version = FactoryGirl.create(:lot_version, lot: lot)
      lot_version.version.should eq(lot.lot_versions.count)
    end
  end
  it "should require a technician" do
    lot_version = FactoryGirl.build(:lot_version, technician_id: nil)
    lot_version.should_not be_valid
    lot_version.errors.full_messages.should include "Technician can't be blank"
  end
  describe "samples" do
    before(:each) do
      @test_suite = FactoryGirl.create(:test_suite_with_standards)
      item_master = FactoryGirl.create(:item_master, test_suite: @test_suite)
      @lot = FactoryGirl.create(:lot, item_master: item_master)
      @lot_version = FactoryGirl.create(:lot_version, lot: @lot)
    end
    it "should be full for each version" do
      # Ensure clean start
      assert_not_nil @test_suite
      assert (@test_suite.test_standards.count > 0)
      assert_equal @lot_version.samples.count, 0
      # Execute
      @lot_version.prepare_samples(@test_suite)
      @lot_version.save!
      # Verify
      @lot_version.samples.count.should eq @test_suite.test_standards.count
    end
    it "should be copied from the previous version" do
      @lot_version.samples.each do |sample|
        sample.data_version_id.should eq @lot_version.id
      end
    end
    it "should be version stamped if changed" do
      # Set up
      @lot_version2 = FactoryGirl.create(:lot_version, lot: @lot)
      @lot_version2.prepare_samples(@test_suite)
      @lot_version2.save!
      # Ensure clean start
      @lot_version2.samples.each do |sample|
        assert_not_equal @lot_version.id, sample.data_version_id
      end
      # Execute
      sample = @lot_version2.samples.last
      new_value = sample.value ||= 99
      sample.update_attributes({value: new_value})
      sample.data_version_id.should eq @lot_version2.id
    end
  end
end
