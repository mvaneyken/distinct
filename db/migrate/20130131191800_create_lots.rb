class CreateLots < ActiveRecord::Migration
  def up
    create_table :lots do |t|
      t.integer :item_master_id
      t.boolean :pass
      t.string :comments

      t.timestamps
    end
    add_foreign_key :lots, :item_masters    
  end
  def down
    remove_foreign_key :lots, :item_masters
    drop_table :lots
  end
end
