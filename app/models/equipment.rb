class Equipment < ActiveRecord::Base
  attr_accessible :name, :manufacturer, :model, :serial_number
  
  has_many :standard_equipments
  
  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :model, presence: true
  validates :serial_number, presence: true, uniqueness: {scope: :manufacturer}
  
end
