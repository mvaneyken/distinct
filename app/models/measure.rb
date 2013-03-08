class Measure < ActiveRecord::Base
  attr_accessible :code, :name, :description
  
  has_many :standards, dependent: :destroy
    
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  def unit_of_measure
    self.code
  end
    
end
