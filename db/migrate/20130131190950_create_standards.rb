class CreateStandards < ActiveRecord::Migration
  def up
    create_table :standards do |t|
      t.string :code
      t.string :property
      t.decimal :min_tolerance, precision: 7, scale: 2
      t.integer :min_tolerance_action_id
      t.decimal :max_tolerance, precision: 7, scale: 2
      t.integer :max_tolerance_action_id
      t.integer :measure_id

      t.timestamps
    end
    add_foreign_key :standards, :tolerance_actions, :column => 'min_tolerance_action_id'
    add_foreign_key :standards, :tolerance_actions, :column => 'max_tolerance_action_id'
    add_foreign_key :standards, :measures
  end
  def down
    remove_foreign_key :standards, :tolerance_actions, :column => 'min_tolerance_action_id'
    remove_foreign_key :standards, :tolerance_actions, :column => 'max_tolerance_action_id'
    remove_foreign_key :standards, :measures
    drop_table :standards
  end
end
