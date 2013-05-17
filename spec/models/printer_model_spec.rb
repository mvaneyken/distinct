require 'spec_helper'

describe PrinterModel do
  it "should let us make add a new one" do
    printer_model = FactoryGirl.create(:printer_model)
    printer_model.save.should be_true
  end
  it "should require an name" do
    printer_model = FactoryGirl.build(:printer_model, name: nil)
    printer_model.should_not be_valid
    printer_model.errors.full_messages.should include "Name can't be blank"
  end
  it "should ensure the name is unique" do
    printer_model1 = FactoryGirl.create(:printer_model)
    printer_model2 = FactoryGirl.build(:printer_model, name: printer_model1.name)
    printer_model2.save.should be_false
    printer_model2.errors.full_messages.should include "Name has already been taken"
  end
end