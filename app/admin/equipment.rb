ActiveAdmin.register Equipment do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.resources')
  
  index do
    column :name
    column :manufacturer
    column :model
    column :serial_number
    default_actions
  end
  
end