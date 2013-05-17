class Client < ActiveRecord::Base
  
  attr_accessible :code, :name
  
  has_many :installations
  
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  
  before_validation :standardize
  
  private
  
  def standardize
    self.code = self.code.upcase if self.code.present?
  end
  
end