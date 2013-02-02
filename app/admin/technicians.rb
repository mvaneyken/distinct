ActiveAdmin.register Technician do
  config.sort_order = "first_name_asc"
  menu parent: I18n.t('admin.resources')
    
end