class Installation < ActiveRecord::Base
  
  attr_accessible :location, :installed_date
  attr_accessible :client_id, :representative_id, :printer_model_id, :ink_system_id, :consumption_profile_id, :printer_function_id
  
  belongs_to :client
  belongs_to :printer_model
  belongs_to :ink_system
  belongs_to :consumption_profile
  belongs_to :printer_function
  belongs_to :representative
  
  validates :client_id, presence: true
  validates :representative_id, presence: true
  validates :printer_model_id, presence: true
  validates :ink_system_id, presence: true
  validates :consumption_profile_id, presence: true
  validates :printer_function_id, presence: true
  validates :location, presence: true
  validates :installed_date, presence: true
  
  delegate :code, :name, to: :client, prefix: true
  delegate :name, to: :representative, prefix: true
  delegate :name, to: :printer_model, prefix: true
  delegate :name, to: :ink_system, prefix: true
  delegate :code, :name, to: :consumption_profile, prefix: true
  delegate :name, to: :printer_function, prefix: true
  
end
