class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
