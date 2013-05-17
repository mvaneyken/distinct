require 'spec_helper'

describe PrinterFunction do
  it "should let us make add a new one" do
    printer_function = FactoryGirl.create(:printer_function)
    printer_function.save.should be_true
  end
  it "should require an name" do
    printer_function = FactoryGirl.build(:printer_function, name: nil)
    printer_function.should_not be_valid
    printer_function.errors.full_messages.should include "Name can't be blank"
  end
  it "should ensure the name is unique" do
    printer_function1 = FactoryGirl.create(:printer_function)
    printer_function2 = FactoryGirl.build(:printer_function, name: printer_function1.name)
    printer_function2.save.should be_false
    printer_function2.errors.full_messages.should include "Name has already been taken"
  end
end