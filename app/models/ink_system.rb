class InkSystem < ActiveRecord::Base
  
  attr_accessible :name
  
  has_many :installations
  
  validates :name, presence: true, uniqueness: true
  
  def can_delete?
    ( self.installations.empty? )
  end
  
end