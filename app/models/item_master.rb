class ItemMaster < ActiveRecord::Base
  attr_accessible :code, :description, :item_type_id, :test_suite_id, :measure_id
  
  belongs_to :item_type
  belongs_to :test_suite
  
  before_validation :standardize
  
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
  
  private
  
  def standardize
    self.code = self.code.upcase if self.code.present?
  end
  
end
