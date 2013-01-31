class CreateStandardEquipments < ActiveRecord::Migration
  def up
    create_table :standard_equipments do |t|
      t.integer :standard_id
      t.integer :equipment_id

      t.timestamps
    end
    add_foreign_key :standard_equipments, :standards
    add_foreign_key :standard_equipments, :equipment
  end
  def down
    remove_foreign_key :standard_equipments, :standards
    remove_foreign_key :standard_equipments, :equipment
    drop_table :standard_equipments
  end
end
