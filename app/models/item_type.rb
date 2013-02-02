class ItemType < ActiveRecord::Base
  attr_accessible :active, :name
  
  has_many :item_masters, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
end
