require 'spec_helper'

describe Representative do
  it "should let us make add a new one" do
    representative = FactoryGirl.create(:representative)
    representative.save.should be_true
  end
  it "should require a first name" do
    representative = FactoryGirl.build(:representative, first_name: nil)
    representative.should_not be_valid
    representative.errors.full_messages.should include "First name can't be blank"
  end
  it "should require a last name" do
    representative = FactoryGirl.build(:representative, last_name: nil)
    representative.should_not be_valid
    representative.errors.full_messages.should include "Last name can't be blank"
  end
  it "should ensure the name is unique" do
    representative1 = FactoryGirl.create(:representative)
    representative2 = FactoryGirl.create(:representative, first_name: representative1.first_name)
    representative3 = FactoryGirl.create(:representative, last_name: representative1.last_name)
    representative4 = FactoryGirl.build(:representative, first_name: representative1.first_name, last_name: representative1.last_name)
    representative4.save.should be_false
    representative4.errors.full_messages.should include "First name has already been taken"
    representative4.errors.full_messages.should include "Last name has already been taken"
  end
  
end