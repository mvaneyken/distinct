ActiveAdmin.register Measure do
  config.sort_order = "code_asc"
  menu parent: I18n.t('admin.references')
    
end