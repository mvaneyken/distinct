require 'spec_helper'

describe Standard do
  it "should let us make add a new one" do
    standard = FactoryGirl.create(:standard)
    standard.save.should be_true
  end
  it "should require an code" do
    standard = FactoryGirl.build(:standard, code: nil)
    standard.should_not be_valid
    standard.errors.full_messages.should include "Code can't be blank"
  end
  it "should require an property" do
    standard = FactoryGirl.build(:standard, property: nil)
    standard.should_not be_valid
    standard.errors.full_messages.should include "Property can't be blank"
  end
  it "should require an measure" do
    standard = FactoryGirl.build(:standard, measure: nil)
    standard.should_not be_valid
    standard.errors.full_messages.should include "Measure can't be blank"
  end
  it "any tolerances actions, should be for tolerances" do
    tolerance_action = FactoryGirl.create(:tolerance_action)
    standard1 = FactoryGirl.build(:standard, min_tolerance: nil, min_tolerance_action_id: tolerance_action.id)
    standard1.should_not be_valid
    standard1.errors.full_messages.should include "Min tolerance action #{I18n.t('standards.errors.min_action_redundant')}"
    standard2 = FactoryGirl.build(:standard, max_tolerance: nil,max_tolerance_action_id: tolerance_action.id)
    standard2.should_not be_valid
    standard2.errors.full_messages.should include "Max tolerance action #{I18n.t('standards.errors.max_action_redundant')}"
  end
end
