ActiveAdmin.register ToleranceAction do
  menu parent: I18n.t('admin.references'), priority: 40
  
  index do
    column :message
    column "Colour" do |row|
      row.colour_name
    end
    column "Standards" do |row|
      zero_blank (row.min_standards.count + row.max_standards.count)
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

    panel "Min Standards" do
      table_for tolerance_action.min_standards do |standard|
        column :code do |row|
          link_to row.code, admin_standard_path(row.id)
        end
        column :property
        column "Minimum" do |row|
          row.min_with_measure
        end
      end
    end

    panel "Max Standards" do
      table_for tolerance_action.max_standards do |standard|
        column :code do |row|
          link_to row.code, admin_standard_path(row.id)
        end
        column :property
        column "Maximum" do |row|
          row.max_with_measure
        end
      end
    end
    
  end
    
end