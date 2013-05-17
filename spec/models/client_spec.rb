require 'spec_helper'

describe Client do
  it "should let us make add a new one" do
    client = FactoryGirl.create(:client)
    client.save.should be_true
  end
  it "should require a code" do
    client = FactoryGirl.build(:client, code: nil)
    client.should_not be_valid
    client.errors.full_messages.should include "Code can't be blank"
  end
  it "should ensure the code is unique" do
    client1 = FactoryGirl.create(:client)
    client2 = FactoryGirl.build(:client, code: client1.code)
    client2.save.should be_false
    client2.errors.full_messages.should include "Code has already been taken"
  end
  it "should require an name" do
    client = FactoryGirl.build(:client, name: nil)
    client.should_not be_valid
    client.errors.full_messages.should include "Name can't be blank"
  end
end