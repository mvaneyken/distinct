class ItemMaster < ActiveRecord::Base
  attr_accessible :code, :description, :item_type_id, :test_suite_id
end
