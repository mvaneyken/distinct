require 'spec_helper'

describe StandardEquipment do
  it "should let us make add a new one" do
    standard_equipment = FactoryGirl.create(:standard_equipment)
    standard_equipment.save.should be_true
  end
end
