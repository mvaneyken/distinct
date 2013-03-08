require 'spec_helper'

describe ToleranceAction do
  it "should let us make add a new one" do
    tolerance_action = FactoryGirl.create(:tolerance_action)
    tolerance_action.save.should be_true
  end  
end
