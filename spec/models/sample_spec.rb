require 'spec_helper'

describe Sample do
  describe "basic validations" do
    it "should let us make add a new one" do
      @sample = FactoryGirl.build(:sample)
      @sample.save.should be_true
    end
  end
  describe "functionality" do
    before(:each) do
      item_master = FactoryGirl.create(:item_master_with_test_suite)
      assert (item_master.test_suite.test_standards.count > 0)
      lot = FactoryGirl.create(:lot, item_master: item_master)
      @lot_version = FactoryGirl.create(:lot_version, lot: lot)
      @lot_version.prepare_samples!
    end
    it "should return sample results" do
      assert (@lot_version.samples.count > 0)
      # Remember this just a stub until the technician records actual values
      sample_stub = @lot_version.samples.first.sample_results
      sample_stub[:standard_id].should_not be_nil
    end
    it "should update value and comments" do
      assert (@lot_version.samples.count > 0)
      # Set up
      sample = @lot_version.samples.first
      technician = Technician.first
      equipment = sample.standard.standard_equipments.first.equipment
      # Ensure clean test
      assert_not_nil technician
      assert_not_nil equipment
      # Execute
      params = {equipment_id: equipment.id, technician_id: technician.id, value: 50, comments: 'Looks nice'}
      sample.update_attributes(params)
      sample.reload
      # Verify
      sample.value.should eq params[:value]
      sample.comments.should eq params[:comments]
    end
    it "should set the data version" do
      # Set up
      sample = @lot_version.samples.first
      # Ensure clean test
      assert_nil sample.data_version
      # Execute
      sample.stamp_data_version!
      # Verify
      sample.reload
      sample.data_version_id.should eq sample.lot_version_id
    end
    it "should fail if value is below tolerance" do
      sample = @lot_version.samples.first
      # Ensure clean test
      assert_nil sample.pass
      assert sample.standard.min_tolerance
      # Execute
      sample.value = (sample.standard.min_tolerance - 1)
      sample.within_tolerance?.should be_false     
    end
    it "should fail if value is above tolerance" do
      sample = @lot_version.samples.first
      # Ensure clean test
      assert_nil sample.pass
      assert sample.standard.max_tolerance
      # Execute
      sample.value = (sample.standard.max_tolerance + 1)
      sample.within_tolerance?.should be_false     
    end
    it "should pass if value is within tolerance" do
      sample = @lot_version.samples.first
      # Ensure clean test
      assert_nil sample.pass
      assert sample.standard.min_tolerance
      assert sample.standard.max_tolerance
      # Execute
      sample.value = ((sample.standard.min_tolerance + sample.standard.max_tolerance) / 2)
      sample.within_tolerance?.should be_true
    end
  end
end
