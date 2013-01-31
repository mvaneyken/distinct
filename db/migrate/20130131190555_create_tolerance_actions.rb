class CreateToleranceActions < ActiveRecord::Migration
  def change
    create_table :tolerance_actions do |t|
      t.string :message
      t.string :colour

      t.timestamps
    end
  end
end
