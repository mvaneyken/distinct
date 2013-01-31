class CreateItemMasters < ActiveRecord::Migration
  def up
    create_table :item_masters do |t|
      t.integer :item_type_id
      t.string :code
      t.string :description
      t.integer :test_suite_id

      t.timestamps
    end
    add_foreign_key :item_masters, :item_types
  end
  def down
    remove_foreign_key :item_masters, :item_types
    drop_table :item_mastewrs
  end
end
