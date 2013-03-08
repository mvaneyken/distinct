class TestSuite < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :test_standards_attributes
  
  has_many :item_masters, dependent: :destroy
  has_many :test_standards, dependent: :destroy
  accepts_nested_attributes_for :test_standards, allow_destroy: true
  
  validates :name, presence: true, uniqueness: true
    
end
