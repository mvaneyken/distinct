require 'spec_helper'

describe ConsumptionProfile do
  it "should let us make add a new one" do
    consumption_profile = FactoryGirl.create(:consumption_profile)
    consumption_profile.save.should be_true
  end
  it "should require a code" do
    consumption_profile = FactoryGirl.build(:consumption_profile, code: nil)
    consumption_profile.should_not be_valid
    consumption_profile.errors.full_messages.should include "Code can't be blank"
  end
  it "should ensure the code is unique" do
    consumption_profile1 = FactoryGirl.create(:consumption_profile)
    consumption_profile2 = FactoryGirl.build(:consumption_profile, code: consumption_profile1.code)
    consumption_profile2.save.should be_false
    consumption_profile2.errors.full_messages.should include "Code has already been taken"
  end
  it "should require an name" do
    consumption_profile = FactoryGirl.build(:consumption_profile, name: nil)
    consumption_profile.should_not be_valid
    consumption_profile.errors.full_messages.should include "Name can't be blank"
  end
end