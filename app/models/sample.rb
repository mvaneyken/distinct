class Sample < ActiveRecord::Base
  attr_accessible :lot_id, :standard_id, :value, :comments, :equipment_id, :technician_id, :data_version_id, :pass
  
  belongs_to :lot_version
  belongs_to :data_version, class_name: "LotVersion"
  belongs_to :standard
  belongs_to :equipment
  belongs_to :technician
  
  delegate :code, to: :standard, allow_nil: true, prefix: :standard
  delegate :property, to: :standard, allow_nil: true, prefix: :standard
  delegate :version, to: :data_version, allow_nil: true, prefix: :data_version
  delegate :unit_of_measure, to: :standard
  
  def self.last_sample(lot_id, standard_id)
    Sample.where(lot_id: lot_id, standard_id: standard_id).order('lot_version_id DESC').limit(1)
  end
  
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
  
  def update_attributes(attributes)
    attributes = attributes.merge({data_version_id: lot_version_id}) if !attributes[:data_version_id]
    super
  end
    
end
