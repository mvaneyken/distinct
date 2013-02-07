class ItemMaster < ActiveRecord::Base
  attr_accessible :code, :description, :item_type_id, :test_suite_id, :measure_id
  
  belongs_to :item_type
  belongs_to :test_suite
  belongs_to :measure
  
  has_many :lots
  
  before_validation :standardize
  
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
  
  def code_description
    "#{self.code} : #{self.description}"
  end
  
  def has_test_suite?
    ( self.test_suite_id )
  end
  
  private
  
  def standardize
    self.code = self.code.upcase if self.code.present?
  end
  
end
