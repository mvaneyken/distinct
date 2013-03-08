class AddLotNumberToLots < ActiveRecord::Migration
  class Lot < ActiveRecord::Base
    attr_accessible :lot_number
  end
  def up
    add_column :lots, :lot_number, :string
    Lot.find_each do |lot|
      lot.lot_number = lot.id.to_s
      lot.save
    end
  end
  def down
    remove_column :lots, :lot_number
  end
end
