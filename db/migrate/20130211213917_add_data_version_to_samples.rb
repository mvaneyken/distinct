class AddDataVersionToSamples < ActiveRecord::Migration
  class Samples < ActiveRecord::Base
    attr_accessible :data_version_id
  end
  def up
    add_column :samples, :data_version_id, :integer
    add_foreign_key :samples, :lot_versions, :column => 'data_version_id'
    Sample.find_each do |sample|
      sample.data_version_id = sample.lot_version_id
      sample.save!
    end
  end
  def down
    remove_column :samples, :data_version_id
    remove_foreign_key :samples, :lot_versions
  end
end
