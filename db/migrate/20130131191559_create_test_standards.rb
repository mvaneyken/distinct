class CreateTestStandards < ActiveRecord::Migration
  def up
    create_table :test_standards do |t|
      t.integer :test_suite_id
      t.integer :standard_id

      t.timestamps
    end
    add_foreign_key :test_standards, :test_suites
    add_foreign_key :test_standards, :standards
  end
  def down
    remove_foreign_key :test_standards, :test_suites
    remove_foreign_key :test_standards, :standards
    drop_table :test_standards
  end
end
