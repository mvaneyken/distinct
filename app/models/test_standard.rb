class TestStandard < ActiveRecord::Base
  attr_accessible :standard_id, :test_suite_id
  
  belongs_to :test_suite
  belongs_to :standard
  
end
