require 'spec_helper'

describe AdminUser do
  it "should let us make add a new one" do
    admin_user = FactoryGirl.create(:admin_user)
    admin_user.save.should be_true
  end
  it "should require an email" do
    admin_user = FactoryGirl.build(:admin_user, email: nil)
    admin_user.should_not be_valid
    admin_user.errors.full_messages.should include "Email can't be blank"
  end
  it "should require a password" do
    admin_user = FactoryGirl.build(:admin_user, password: nil)
    admin_user.should_not be_valid
    admin_user.errors.full_messages.should include "Password can't be blank"
  end
  it "should require a password confirmation" do
    admin_user = FactoryGirl.build(:admin_user, password: "a_password", password_confirmation: "wrong_confirmation")
    admin_user.should_not be_valid
    admin_user.errors.full_messages.should include "Password doesn't match confirmation"
  end
end
