class Lot < ActiveRecord::Base
  attr_accessible :lot_number, :comments, :item_master_id
  attr_accessible :lot_versions_attributes
  
  belongs_to :item_master
  has_many :lot_versions, dependent: :destroy, order: :version
  accepts_nested_attributes_for :lot_versions, allow_destroy: true
  
  validates :item_master_id, presence: true
  validates :lot_number, presence: true, uniqueness: true
  
  before_validation :standardize
  
  def build_new_version(technician_id)
    lv = self.lot_versions.build(technician_id)
    lv.prepare_samples(self.item_master.test_suite)
  end
  
  # Retrieve the most recent sample for a given standard
  def last_sample(standard_id)
    Sample.joins("join lot_versions on samples.lot_version_id = lot_versions.id").where("lot_versions.lot_id = ? and samples.standard_id = ?", self.id, standard_id).order("samples.id DESC").limit(1).first
  end
  
  def passed?
    (self.lot_versions.present? && self.lot_versions.last.passed?)
  end
  
  private
  
  def standardize
    self.lot_number = self.lot_number.upcase if self.lot_number
  end
  
end
