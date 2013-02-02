ActiveAdmin.register ItemMaster do
  config.sort_order = "code_asc"
  menu parent: I18n.t('admin.references'), priority: 20
  
  index do
    column :code
    column :item_type
    column :description
    column :test_suite
    default_actions
  end
  
  form do |f|
    f.inputs do
      f.input :code
      f.input :item_type
      f.input :description
      f.input :test_suite
    end
    f.buttons
  end
  
end