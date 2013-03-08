require 'spec_helper'

describe ItemType do
  it "should let us make add a new one" do
    item_type = FactoryGirl.create(:item_type)
    item_type.save.should be_true
  end
  it "should require an name" do
    item_type = FactoryGirl.build(:item_type, name: nil)
    item_type.should_not be_valid
    item_type.errors.full_messages.should include "Name can't be blank"
  end
end
