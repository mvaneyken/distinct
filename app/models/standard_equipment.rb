class StandardEquipment < ActiveRecord::Base
  attr_accessible :equipment_id, :standard_id
  
  belongs_to :equipment
  belongs_to :standard
  
  delegate :name, to: :equipment
  
end
