class Sample < ActiveRecord::Base
  attr_accessible :standard_id, :value, :comments, :equipment_id, :technician_id, :data_version_id, :pass
  
  belongs_to :lot_version
  belongs_to :data_version, class_name: "LotVersion"
  belongs_to :standard
  belongs_to :equipment
  belongs_to :technician
  
  before_save :set_pass_fail
  
  delegate :code, to: :standard, allow_nil: true, prefix: :standard
  delegate :property, to: :standard, allow_nil: true, prefix: :standard
  delegate :version, to: :data_version, allow_nil: true, prefix: :data_version
  delegate :unit_of_measure, to: :standard
  
  # Class
  # -----------------------------
  
  scope :passed, where("pass is not null")
  
  def self.last_sample(lot_id, standard_id)
    Sample.where("lot_version_id in (select id from lot_versions where lot_id = #{lot_id} order by version DESC limit(1)) and standard_id = #{standard_id}").first
  end
  
  # Instance
  # -----------------------------

  def sample_results
    {
      standard_id: self.standard_id, 
      equipment_id: self.equipment_id, 
      technician_id: self.technician_id,
      value: self.value,
      pass: self.pass,
      comments: self.comments,
      data_version_id: self.data_version_id
      }
  end
  
  def stamp_data_version!
    self.data_version_id = self.lot_version_id
    self.save!
  end
  
  def set_pass_fail
    self.pass = self.within_tolerance?
    true
  end
  
  def within_tolerance?(value = self.value)
    (self.standard.min_tolerance <= value) && (value <= self.standard.max_tolerance) if value 
  end
  
  def failed?
    ( self.value && !within_tolerance? )
  end
  
end
