class LotVersion < ActiveRecord::Base
  attr_accessible :lot_id, :comments, :technician_id
  attr_accessible :samples_attributes
  
  belongs_to :lot
  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true
  
  validates :technician_id, presence: true
  
  before_create :issue_version_number
  
  def prepare_samples(test_suite)
    test_suite.test_standards.each do |ts|
      self.samples.build(standard_id: ts.standard_id, technician_id: self.technician_id)
    end
  end
  
  private
  
  def issue_version_number
    self.version = self.lot.lot_versions.count + 1
  end
  
end
