ActiveAdmin.register ItemType do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.references')
    
end