class Sample < ActiveRecord::Base
  attr_accessible :lot_id, :standard_id, :value, :comments, :equipment_id, :technician_id
  
  belongs_to :lot_version
  belongs_to :standard
  belongs_to :equipment
  belongs_to :technician
  
  delegate :code, to: :standard, allow_nil: true, prefix: :standard
  
end
