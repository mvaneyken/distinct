require 'spec_helper'

describe Measure do
  it "should let us make add a new one" do
    measure = FactoryGirl.create(:measure)
    measure.save.should be_true
  end
  it "should require an code" do
    measure = FactoryGirl.build(:measure, code: nil)
    measure.should_not be_valid
    measure.errors.full_messages.should include "Code can't be blank"
  end
end
