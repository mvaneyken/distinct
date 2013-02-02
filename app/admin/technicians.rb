ActiveAdmin.register Technician do
  config.sort_order = "first_name_asc"
  menu parent: I18n.t('admin.security')
  filter :first_name
  filter :last_name
  filter :email
  
  index do
    column :first_name
    column :last_name
    column :email
    default_actions
  end

  show do
    attributes_table_for technician do
      row :first_name
      row :last_name
      row :email
      row :last_sign_in_at
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
  
end