ActiveAdmin.register ItemType do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.references'), priority: 10
  
  index do
    column :name
    column :active
    default_actions
  end
  
end