class Batch < ActiveRecord::Base
  attr_accessible :comment, :item_master_id
  
  belongs_to :item_master
  
  validates :item_master_id, presence: true
  
end
