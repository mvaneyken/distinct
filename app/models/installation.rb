require 'csv'

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
  
  def self.csv_columns
    [:client_code, :client_name, :printer_model_name, :ink_system_name, :consumption_profile_code, :printer_function_name, :representative_name, :location, :installed_date]
  end
  
  def self.import_csv(file)
    col = self.csv_columns
    results = []
    indx = 0
    CSV.parse(file, headers: true) do |row|
      indx += 1
      message = nil
      col.each_with_index do |field, indx|
        message = "#{field} missing" if !row[indx]
      end
      if !message
        client_code = row[col.index(:client_code)]
        client = Client.find_by_code(client_code)
        if !client
          client = Client.new(code: client_code, name: row[col.index(:client_name)])
          message = client.errrors.full_messages.join(', ') if !client.save
        end
      end
      if !message
        printer_model = PrinterModel.find_or_create_by_name(row[col.index(:printer_model_name)])
        ink_system = InkSystem.find_or_create_by_name(row[col.index(:ink_system_name)])
        consumption_profile = ConsumptionProfile.find_or_create_by_code(row[col.index(:consumption_profile_code)])
        printer_function = PrinterFunction.find_or_create_by_name(row[col.index(:printer_function_name)])
        names = row[col.index(:representative_name)].split(' ')
        first_name = names[0]
        last_name = names.drop(1).join(' ')
        representative = Representative.where("first_name = ? and last_name = ?", first_name, last_name).first
        message = "Representative #{first_name} #{last_name} required" if !representative
        installed_date = Date.parse(row[col.index(:installed_date)])
        if !message
          installation = Installation.new(
            client_id: client.id,
            printer_model_id: printer_model.id,
            ink_system_id: ink_system.id,
            consumption_profile_id: consumption_profile.id,
            printer_function_id: printer_function.id,
            representative_id: representative.id,
            location: row[col.index(:location)],
            installed_date: installed_date
            )
          if installation.save
            message = "Installation added"
          else
            message = installation.errors.full_messages.join(', ')
          end
        end
      end
      results << [indx, message, row.to_s]
    end
    results
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << self.csv_columns
      self.order(:client_id, :location).each do |installation|
        csv << [
          installation.client_code,
          installation.client_name,
          installation.printer_model_name,
          installation.ink_system_name, 
          installation.consumption_profile_code, 
          installation.printer_function_name,
          installation.representative_name,
          installation.location,
          installation.installed_date.strftime('%Y%m%d')
          ]
      end
    end
  end
  
end
