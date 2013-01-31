class CreateBatches < ActiveRecord::Migration
  def up
    create_table :batches do |t|
      t.integer :item_master_id
      t.boolean :pass
      t.string :comment

      t.timestamps
    end
    add_foreign_key :batches, :item_masters    
  end
  def down
    remove_foreign_key :batches, :item_masters
    drop_table :batches
  end
end
