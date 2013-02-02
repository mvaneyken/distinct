class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :manufacturer
      t.string :model
      t.string :serial_number

      t.timestamps
    end
  end
end
