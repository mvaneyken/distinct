class Installations < ActiveRecord::Migration
  
  class PrinterModel < ActiveRecord::Base
    attr_accessible :name
  end
  class InkSystem < ActiveRecord::Base
    attr_accessible :name
  end
  class ConsumptionProfile < ActiveRecord::Base
    attr_accessible :code, :name
  end
  class PrinterFunction < ActiveRecord::Base
    attr_accessible :name
  end
  
  def up
    create_table :clients do |t|
      t.string :code
      t.string :name
      
      t.timestamps
    end
    create_table :representatives do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    create_table :printer_models do |t|
      t.string :name
      
      t.timestamps
    end
    %w{4000 4800 4900 7600 7700 7800 7880 7890 7900 9600 9700 9800 9880 9890 9900 Other}.each do |name|
      printer_model = PrinterModel.new(name: name)
      printer_model.save!
    end    
    create_table :ink_systems do |t|
      t.string :name
      
      t.timestamps
    end
    %w{BIS RMC CIS}.each do |name|
      ink_system = InkSystem.new(name: name)
      ink_system.save!
    end
    create_table :consumption_profiles do |t|
      t.string :code
      t.string :name
      
      t.timestamps
    end
    %w{A B C}.each do |code|
      consumption_profile = ConsumptionProfile.new(code: code, name: "Type #{code} consumption profile")
      consumption_profile.save!
    end
    create_table :printer_functions do |t|
      t.string :name
      
      t.timestamps
    end
    %w{Proof Repro Mix Film Other}.each do |name|
      printer_function = PrinterFunction.new(name: name)
      printer_function.save!
    end
    create_table :installations do |t|
      t.integer :client_id
      t.string :location
      t.integer :printer_model_id
      t.integer :ink_system_id
      t.date :installed_date
      t.integer :consumption_profile_id
      t.integer :representative_id
      t.integer :printer_function_id
      
      t.timestamps
    end
  end

  def down    
    drop_table :clients
    drop_table :representatives
    drop_table :printer_models
    drop_table :ink_systems
    drop_table :consumption_profiles
    drop_table :printer_functions
  end
end
