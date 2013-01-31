class CreateSamples < ActiveRecord::Migration
  def up
    create_table :samples do |t|
      t.integer :batch_id
      t.integer :standard_id
      t.integer :equipment_id
      t.integer :technician_id
      t.decimal :value
      t.boolean :pass
      t.string :comment

      t.timestamps
    end
    add_foreign_key :samples, :batches, :column => 'batch_id'
    add_foreign_key :samples, :standards
    add_foreign_key :samples, :equipment
    add_foreign_key :samples, :technicians
  end
  def down
    remove_foreign_key :samples, :batches, :column => 'batch_id'
    remove_foreign_key :samples, :standards
    remove_foreign_key :samples, :equipment
    remove_foreign_key :samples, :technicians
    drop_table :samples
  end
end
