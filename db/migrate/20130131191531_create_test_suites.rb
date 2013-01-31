class CreateTestSuites < ActiveRecord::Migration
  def up
    create_table :test_suites do |t|
      t.string :name

      t.timestamps
    end
    add_foreign_key :item_masters, :test_suites
  end
  def down
    remove_foreign_key :item_masters, :test_suites  
    drop_table :test_suites
  end
end
