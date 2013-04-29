class Standard < ActiveRecord::Base
  attr_accessible :code, :property, :min_tolerance, :min_tolerance_action_id, :max_tolerance, :max_tolerance_action_id, :measure_id
  attr_accessible :standard_equipments_attributes
  
  attr_accessor :min_tolerance_message, :max_tolerance_message
  attr_accessible :min_tolerance_message, :max_tolerance_message
  
  belongs_to :measure
  belongs_to :min_tolerance_action, class_name: 'ToleranceAction'
  belongs_to :max_tolerance_action, class_name: 'ToleranceAction'
  
  has_many :test_standards, dependent: :destroy
  has_many :standard_equipments, dependent: :destroy
  accepts_nested_attributes_for :standard_equipments, allow_destroy: true
  has_many :samples, dependent: :destroy
  
  before_validation :standardize
  
  validates :code, presence: true, uniqueness: true
  validates :property, presence: true
  validates :measure, presence: true
  validate :tolerances_described
  
  delegate :unit_of_measure, to: :measure
  
  def code_property
    "#{code} : #{property}"
  end
  
  def min_with_measure
    self.min_tolerance ? "#{self.min_tolerance} #{self.measure.code}" : ""
  end
  
  def max_with_measure
    self.max_tolerance ? "#{self.max_tolerance} #{self.measure.code}" : ""
  end
  
  def can_delete?
    ( self.test_standards.empty? )
  end
  
  def min_tolerance_message
    self.min_tolerance_action_id ? self.min_tolerance_action.message : ''
  end
  
  def min_tolerance_message=(value)
    obj = ToleranceAction.find_by_message(value)
    self.min_tolerance_action_id = obj ? obj.id : nil
  end
  
  def max_tolerance_message
    self.max_tolerance_action_id ? self.max_tolerance_action.message : ''
  end
  
  def max_tolerance_message=(value)
    obj = ToleranceAction.find_by_message(value)
    self.max_tolerance_action_id = obj ? obj.id : nil
  end
  
  private
  
  def standardize
    self.code = self.code.upcase if self.code
  end
  
  def tolerances_described
    errors.add(:base, I18n.t('standards.errors.tolerance_reqd')) if !(min_tolerance || max_tolerance)
    errors.add(:min_tolerance_action_id, I18n.t('standards.errors.min_action_redundant')) if min_tolerance_action_id && !min_tolerance
    errors.add(:max_tolerance_action_id, I18n.t('standards.errors.max_action_redundant')) if max_tolerance_action_id && !max_tolerance
  end
  
end
