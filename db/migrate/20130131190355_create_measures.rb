class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
