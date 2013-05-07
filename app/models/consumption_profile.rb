class ConsumptionProfile < ActiveRecord::Base
  
  attr_accessible :code, :name
  
  has_many :installations
  
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  before_validation :standardize
  
  def can_delete?
    ( self.installations.empty? )
  end
  
  private
  
  def standardize
    self.code = self.code.upcase if self.code
  end
  
end