ActiveAdmin.register ToleranceAction do
  menu parent: I18n.t('admin.references'), priority: 40
  
  index do
    column :message
    column "Colour" do |row|
      row.colour_name
    end
    default_actions
  end
  
  form do |f|
    f.inputs do
      f.input :message
      f.input :colour, collection: ToleranceAction::COLOURS
    end
    f.buttons
  end
  
  show do
    attributes_table do 
      row :message
      row :colour_name
    end
  end
    
end