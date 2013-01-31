class Equipment < ActiveRecord::Base
  attr_accessible :manufacturer, :model, :serial_number
end
