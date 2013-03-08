require 'spec_helper'

describe Technician do
  it "should let us make add a new one" do
    technician = FactoryGirl.create(:technician)
    technician.save.should be_true
  end
  it "should require an email" do
    technician = FactoryGirl.build(:technician, email: nil)
    technician.should_not be_valid
    technician.errors.full_messages.should include "Email can't be blank"
  end
  it "should require a password" do
    technician = FactoryGirl.build(:technician, password: nil)
    technician.should_not be_valid
    technician.errors.full_messages.should include "Password can't be blank"
  end
  it "should require a password confirmation" do
    technician = FactoryGirl.build(:technician, password: "a_password", password_confirmation: "wrong_confirmation")
    technician.should_not be_valid
    technician.errors.full_messages.should include "Password doesn't match confirmation"
  end
  it "should require a first name" do
    technician = FactoryGirl.build(:technician, first_name: nil)
    technician.should_not be_valid
    technician.errors.full_messages.should include "First name can't be blank"
  end
  it "should require a last name" do
    technician = FactoryGirl.build(:technician, last_name: nil)
    technician.should_not be_valid
    technician.errors.full_messages.should include "Last name can't be blank"
  end
end
