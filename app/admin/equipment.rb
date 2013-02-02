ActiveAdmin.register Equipment do
  config.sort_order = "manufacturer_asc"
  menu parent: I18n.t('admin.resources')
    
end