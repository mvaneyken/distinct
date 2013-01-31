class Standard < ActiveRecord::Base
  attr_accessible :name, :min_tolerence, :min_tolerance_action_id, :max_tolerance, :max_tolerance_action_id, :measure_id
  
end
