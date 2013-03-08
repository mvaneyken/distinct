require 'spec_helper'

describe Equipment do
  it "should let us make add a new one" do
    equipment = FactoryGirl.create(:equipment)
    equipment.save.should be_true
  end
  it "should require an name" do
    equipment = FactoryGirl.build(:equipment, name: nil)
    equipment.should_not be_valid
    equipment.errors.full_messages.should include "Name can't be blank"
  end
  it "should require an manufacturer" do
    equipment = FactoryGirl.build(:equipment, manufacturer: nil)
    equipment.should_not be_valid
    equipment.errors.full_messages.should include "Manufacturer can't be blank"
  end
  it "should require an model" do
    equipment = FactoryGirl.build(:equipment, model: nil)
    equipment.should_not be_valid
    equipment.errors.full_messages.should include "Model can't be blank"
  end
  it "should require an serial_number" do
    equipment = FactoryGirl.build(:equipment, serial_number: nil)
    equipment.should_not be_valid
    equipment.errors.full_messages.should include "Serial number can't be blank"
  end
end
