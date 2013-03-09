class TestSuite < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :test_standards_attributes
  
  has_many :item_masters, dependent: :destroy
  has_many :test_standards, dependent: :destroy
  accepts_nested_attributes_for :test_standards, allow_destroy: true
  
  validates :name, presence: true, uniqueness: true
  
  # Class
  # -----------------------------
  
  def self.duplicate(source)
    duplicate = source.dup
    version = TestSuite.where("name like '#{source.name}%'").count + 1
    duplicate.name += ".v" + version.to_s
    source.test_standards.each do |test_standard|
      duplicate.test_standards.build(test_standard.to_data_hash)
    end
    duplicate.save!
    duplicate
  end
  
end
