class Lot < ActiveRecord::Base
  attr_accessible :comments, :item_master_id
  attr_accessible :lot_versions_attributes
  
  belongs_to :item_master
  has_many :lot_versions, dependent: :destroy
  accepts_nested_attributes_for :lot_versions, allow_destroy: true
  
  validates :item_master_id, presence: true
  
  def build_new_version(technician_id)
    lv = self.lot_versions.build(technician_id)
    lv.prepare_samples(self.item_master.test_suite)
  end
  
end
