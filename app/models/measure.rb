class Measure < ActiveRecord::Base
  attr_accessible :code, :name, :description
    
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
    
end
