require 'spec_helper'

describe Lot do
  it "should reject if item_master is missing" do
    lot = build(:lot, item_master_id: nil)
    lot.should_not be_valid
  end
end
