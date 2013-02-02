ActiveAdmin.register Measure do
  config.sort_order = "code_asc"
  menu parent: I18n.t('admin.references'), priority: 30
  
  index do
    column :code
    column :name
    column :description
    default_actions
  end
  
  show do
    attributes_table do
      row :code
      row :name
      row :description
    end
  end    
    
end