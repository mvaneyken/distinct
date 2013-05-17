require 'spec_helper'

describe InkSystem do
  it "should let us make add a new one" do
    ink_system = FactoryGirl.create(:ink_system)
    ink_system.save.should be_true
  end
  it "should require an name" do
    ink_system = FactoryGirl.build(:ink_system, name: nil)
    ink_system.should_not be_valid
    ink_system.errors.full_messages.should include "Name can't be blank"
  end
  it "should ensure the name is unique" do
    ink_system1 = FactoryGirl.create(:ink_system)
    ink_system2 = FactoryGirl.build(:ink_system, name: ink_system1.name)
    ink_system2.save.should be_false
    ink_system2.errors.full_messages.should include "Name has already been taken"
  end
end