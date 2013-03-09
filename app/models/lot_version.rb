class LotVersion < ActiveRecord::Base
  attr_accessible :lot_id, :comments, :technician_id
  attr_accessible :samples_attributes
  
  belongs_to :lot
  has_many :samples, order: :created_at, dependent: :destroy
  belongs_to :technician
  accepts_nested_attributes_for :samples, allow_destroy: true
  
  validates :technician_id, presence: true
  
  before_create :issue_version_number
  
  delegate :last_sample, to: :lot, allw_nil: true, prefix: :lot 
  
  # Copy forward the most recently available sample result for the lot, or initiate a new sample
  def prepare_samples(test_suite = self.lot.item_master.test_suite)
    test_suite.test_standards.each do |ts|
      last_sample = self.lot.last_sample(ts.standard_id)
      if last_sample
        self.samples.build(last_sample.sample_results)
      else
        self.samples.build(standard_id: ts.standard_id, technician_id: self.technician_id)
      end
    end
  end
  
  def prepare_samples!(test_suite = self.lot.item_master.test_suite)
    self.prepare_samples test_suite
    self.save!
  end
    
  def issue_version_number
    self.version = self.lot.lot_versions.count + 1 if !self.version
  end
  
  def passed?
    ( self.samples.present? && self.samples.passed.count >= self.samples.count )
  end
      
end
