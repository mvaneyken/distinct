class CreateLotVersions < ActiveRecord::Migration
  def up
    create_table :lot_versions do |t|
      t.integer :lot_id
      t.integer :version
      t.string :comments
      t.integer :technician_id

      t.timestamps
    end
    add_foreign_key :lot_versions, :lots, :column => 'lot_id'
    # Disconnect samples from lots
    remove_foreign_key :samples, :lots
    remove_column :samples, :lot_id
    # Connect samples to lot_versions
    add_column :samples, :lot_version_id, :integer
    add_foreign_key :samples, :lot_versions, :column => 'lot_version_id'
  end
  def down
    remove_foreign_key :lot_versions, :lots
    drop_table :lot_versions
    # Reconnect samples to lots
    add_foreign_key :samples, :lots, :column => 'lot_id'
    add_column :samples, :lot_id, :integer
    # Disconnect samples from lot_versions
    remove_foreign_key :samples, :lot_versions
    remove_solumn :samples, :lot_version_id
  end
end
